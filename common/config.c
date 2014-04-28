#include "config.h"

float stablize_Kp = 5;
int LOG_LEVEL = LOG_SDCARD;

#if QUADCOPTER == 1

float pid_limit[3][3] = 				// pid_limit[roll,pitch,yaw][p max offset, I limit, d dummy]
{
	{PI, PI/3.6, 1},
	{PI, PI/3.6, 1},
	{PI/2, PI/3.6, 1},
};
float pid_factor[3][3] = 			// pid_factor[roll,pitch,yaw][p,i,d]
{
	{0.35, 0.35, 0.035,},
	{0.35, 0.35, 0.035,},
	{1.75, 0.25, 0,},
};
float pid_factor2[3][3] = 			// pid_factor2[roll,pitch,yaw][p,i,d]
{
	{6, 0, 0.05,},
	{6, 0, 0.05,},
	{4, 0, 0.05,},
};
float quadcopter_trim[3]
= 
{
	-0 * PI / 180,			// roll
	-0 * PI / 180,			// pitch
	0,							// yaw
};

#else

float pid_limit[3][3] = 				// pid_limit[roll,pitch,yaw][p max offset, I limit, d dummy]
{
	{PI/2, PI/3, 1},
	{PI/2, PI/3, 1},
	{PI/2, PI/3, 1},
};
violate float pid_factor[3][3] = 			// pid_factor[roll,pitch,yaw][p,i,d]
{
	{1.50, 0.05, 0.36,},
	{1.50, 0.05, 0.36,},
	//{0, 0.0, 20,},
	//{0, 0.0, 20,},
	{0, 0, 0,},
};

#endif
