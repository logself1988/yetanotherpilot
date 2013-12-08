#ifndef __CONFIG_H__
#define __CONFIG_H__

// printf debug configuration
#define TRACE(...) 
#define ITM_DBG
#define USART1_DBG
#define SW_I2C

#ifndef STATION
#undef USART1_DBG
#endif

// pilot configuration
#define QUADCOPTER 0
#define PI 3.14159265
#define interval (0.008)

#define RC_TIMEOUT 1000000				// 1 seconds
#define RC_RANGE 400
#define RC_DEAD_ZONE 5
#define RC_CENTER 1520
#define BARO_OSS 50
#define ref_vaoltage 3.366
#define resistor_total 61.3
#define resistor_vaoltage 9.89

#define ACRO_ROLL_RATE (PI*3/2)				// 270 degree/s
#define ACRO_PITCH_RATE (PI)			// 180 degree/s
#define ACRO_YAW_RATE (PI/2)			// 90 degree/s
#if QUADCOPTER == 1
#define ACRO_MANUAL_FACTOR (0.0)
static float pid_factor[3][3] = 			// pid_factor[roll,pitch,yaw][p,i,d]
{
	{0.2, 0.05, 6,},
	{0.2, 0.05, 6,},
	{0.2, 0, 0,},
};
static float pid_limit[3][3] = 				// pid_limit[roll,pitch,yaw][p max offset, I limit, d dummy]
{
	{PI/6, PI/3, 1},
	{PI/6, PI/3, 1},
	{PI/6, PI/3, 1},
};
static float quadcopter_trim[3] = 
{
	-4.5 * PI / 180,				// roll
	-2.5 * PI / 180,			// pitch
	0,							// yaw
};

static float quadcopter_range[3] = 
{
	PI/36,			// roll targe on RC full deflection
	PI/36,			// pitch
	PI/36,			// yaw
};

static int quadcopter_mixing_matrix[4][3] = // the motor mixing matrix, [motor number] [roll, pitch, yaw]
{
	{0, +1, -1},			// rear
	{-1, 0, +1},			// right
	{0, -1, -1},			// front
	{+1, 0, +1},			// left
};
#else
#define ACRO_MANUAL_FACTOR (0.3)		// final output in acrobatic mode, 70% pid, 30% rc
static float pid_factor[3][3] = 			// pid_factor[roll,pitch,yaw][p,i,d]
{
	//{0.667, 0.066, 0,},
	//{0.667, 0.066, 0,},
	{0, 0.0, 20,},
	{0, 0.0, 20,},
	{0, 0, 0,},
};
static float pid_limit[3][3] = 				// pid_limit[roll,pitch,yaw][p max offset, I limit, d dummy]
{
	{PI/4, PI/2, 1},
	{PI/4, PI/2, 1},
	{PI/6, PI/3, 1},
};
#endif

#define QUADCOPTER_MAX_DELTA 100





#define ACRO_MAX_ROLL_OFFSET (pid_limit[0][0])		// 30 degree, max roll advance before airframe can response in acrobatic mode
#define ACRO_MAX_PITCH_OFFSET (pid_limit[1][0])	// 30 degree, max pitch advance before airframe can response in acrobatic mode
#define ACRO_MAX_YAW_OFFSET (pid_limit[2][0])		// 30 degree, max yaw advance before airframe can response in acrobatic mode

static int rc_reverse[3] = 								// -1 = reverse, 1 = normal, 0 = disable, won't affect mannual mode
{
	1,			// roll
	1,			// pitch
	1,			// yaw
};

static int sensor_reverse[3] = 						// -1 = reverse, 1 = normal, 0 = disable, won't affect mannual mode
{
	-1,			// roll
	-1,			// pitch
	-1,			// yaw
};


// station configuration

#endif
