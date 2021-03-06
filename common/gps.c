#include "gps.h"
#include "build.h"
#include <string.h>
#include <stdio.h>
#include "mcu.h"
#include "common.h"

static nmeaINFO info;
static nmeaPARSER parser;
static char buffer[GPS_BUFFER_BLOCK];		// circular buffer
static int start = 0;						// valid data start in circular
static int end = 0;						// valid data length in circular buffer
static int end_sentence = 0;				// valid sentence length in circular buffer

void USART1_IRQHandler(void)
{
	int c = -1;
	if(USART_GetFlagStatus(USART1,USART_IT_RXNE)==SET
#ifdef STM32F4
		|| USART_GetFlagStatus(UART4,USART_IT_ORE_RX)==SET
#endif
		)
	{
		c = USART_ReceiveData(USART1);
	}
	USART_ClearITPendingBit(USART1, USART_IT_RXNE);
	
	if (c>0)
	{
		buffer[end] = c;
		end++;
		end %= GPS_BUFFER_BLOCK;
		if (c == '\n')
			end_sentence = end;
		buffer[end] = 0;
	}
}

void GPS_Init(uint32_t baud_rate)
{
	GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	NVIC_InitTypeDef NVIC_InitStructure;

	
	// config USART1 clock and its GPIO Clock
#ifdef STM32F1
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1 | RCC_APB2Periph_GPIOA, ENABLE);
#endif
#ifdef STM32F4
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1, ENABLE);
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);
#endif
	
	// USART1 GPIO (A9(TX) & A10(RX))config 
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;
#ifdef STM32F1
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
#endif
#ifdef STM32F4
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
	GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
	GPIO_PinAFConfig(GPIOA, GPIO_PinSource9, GPIO_AF_USART1);
	GPIO_PinAFConfig(GPIOA, GPIO_PinSource10, GPIO_AF_USART1);
#endif
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
#ifdef STM32F1
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
#endif
#ifdef STM32F4
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
	GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
#endif
	GPIO_Init(GPIOA, &GPIO_InitStructure);
	

	// NVIC config
  	NVIC_InitStructure.NVIC_IRQChannel = USART1_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 3;
  	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  	NVIC_Init(&NVIC_InitStructure);
	  
	// USART1 mode config
	USART_InitStructure.USART_BaudRate = baud_rate;
	USART_InitStructure.USART_WordLength = USART_WordLength_8b;
	USART_InitStructure.USART_StopBits = USART_StopBits_1;
	USART_InitStructure.USART_Parity = USART_Parity_No ;
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
	USART_Init(USART1, &USART_InitStructure); 
	USART_Cmd(USART1, ENABLE);
	USART_ITConfig(USART1, USART_IT_RXNE, ENABLE);

	// NMEA init
	nmea_zero_INFO(&info);
	nmea_parser_init(&parser);
}

extern int parse_command_line(const char *line, char *out);


static int parse_command(char *cmd)
{
	int response_size;
	char response[200];
	int i;
	do
	{
		char *next = (char*)strchr(cmd, '\n');
		if (next)
			next[0] = 0;

		response_size = parse_command_line(cmd, response);
		for(i=0; i<response_size; i++)
		{
			USART_SendData(USART1, (unsigned char) response[i]);
			while (!(USART1->SR & USART_FLAG_TXE));
		}
		USART_SendData(USART1, '\n');
		while (!(USART1->SR & USART_FLAG_TXE));
		
		
		cmd = next+1;
		
		

		if (!next)
			break;
	}while (1);

	return 0;
}

char to_parse[GPS_BUFFER_BLOCK];
int GPS_ParseBuffer()
{
	int _end_sentence = end_sentence;
	int j=0;
	int i;
	
	if (_end_sentence == start)
		return 0;
	for(i=start; i!= _end_sentence; i=(i+1)%GPS_BUFFER_BLOCK, j++)
		to_parse[j] = buffer[i];
	
	to_parse[j] = 0;
	TRACE("GPS:%s", to_parse);
	
	start = _end_sentence;

	if (to_parse[0] == '$')
		return nmea_parse(&parser, to_parse, j, &info);
	else
		return parse_command(to_parse);
}

nmeaINFO* GPS_GetInfo()
{
	return &info;
}
