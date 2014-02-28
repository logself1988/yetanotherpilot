#include <stdio.h>
#include <conio.h>
#include <math.h>

typedef __int64 int64_t;
#include "..\RFData.h"
#include "..\common\vector.h"
#include "..\common\common.h"


float NDEG2DEG(float ndeg)
{
	int degree = ndeg / 100;
	int minute = int(floor(ndeg)) % 100;	

	return degree + minute/60.0f + modf(ndeg, &ndeg)/60.0f;
}

int main(int argc, char **argv)
{
	vector test = {0,0,1};
	vector gyro = {0,PI/20000,0};
	
	for(int i=0; i<10000; i++)
		vector_rotate(&test, gyro.array);

	if (argc<=1)
	{
		printf("dat2csv file\r\n");

		getch();

		return -1;
	}

	rf_data rf;
	pilot_data pilot = {0};
	pilot_data2 pilot2 = {0};
	imu_data imu = {0};
	sensor_data sensor = {0};
	ppm_data ppm = {0};
	gps_data_v1 gps_v1 = {0};
	gps_data gps = {0};


	FILE * f = fopen(argv[1], "rb");
	FILE * fo = NULL;
	FILE * gpso = NULL;
	FILE * gyrof = fopen("gyro.dat", "wb");
	int n = 0;
	int packet = 0;
	int file = 0;
	char tmp[200];
	int64_t lasttime = 9999999999;
	while (fread(&rf, 1, 32, f) == 32)
	{
		int64_t time = rf.time & ~TAG_MASK;
		if ((rf.time & TAG_MASK) ==  TAG_IMU_DATA)
			imu = rf.data.imu;
		else if ((rf.time & TAG_MASK) ==  TAG_PILOT_DATA)
			pilot = rf.data.pilot;
		else if ((rf.time & TAG_MASK) ==  TAG_PILOT_DATA2)
			pilot2 = rf.data.pilot2;
		else if ((rf.time & TAG_MASK) ==  TAG_GPS_DATA)
			gps = rf.data.gps;
		else if ((rf.time & TAG_MASK) ==  TAG_GPS_DATA_V1)
			gps_v1 = rf.data.gps_v1;
		else if ((rf.time & TAG_MASK) ==  TAG_SENSOR_DATA)
		{
			sensor = rf.data.sensor;
			fwrite(sensor.gyro, 1, 6, gyrof);
		}
		else if ((rf.time & TAG_MASK) ==  TAG_PPM_DATA)
			ppm = rf.data.ppm;
		else
		{
			printf("unknown data %x, skipping\r\n", int((rf.time & TAG_MASK)>>56));
		}

		float *lll = &gps.longitude;

		if (time < lasttime)
		{
			if (fo)
				fclose(fo);
			if (gpso)
				fclose(gpso);
			file ++;
			sprintf(tmp, "out%d.csv", file);
			fo = fopen(tmp, "wb");
			fprintf(fo, "time,voltage,current,overload,altitude,accel[0],aceel[1],accel[2],gyro[0](-roll_rate),gyro[1](-pitch_rate),gyro[2],error[0],error[1],error[2],errorI[0],errorD[0],roll,pitch,yaw_gyro,roll_t,pitch_t,yaw_t,throttle, mode,ppmi[0],ppmi[1],ppmi[2],ppmi[3],ppmo[0],ppmo[1],ppmo[2],ppmo[3],est[0],est[1],est[2],gyro[0],gyro[1],gyro[2]\r\n");
			sprintf(tmp, "gps%d.csv", file);
			gpso = fopen(tmp, "wb");
			fprintf(gpso, "time,latitude,longitude,speed\r\n");
		}

		lasttime = time;

		vector estAccGyro = {imu.estAccGyro[0], imu.estAccGyro[1], imu.estAccGyro[2]};
		vector estMagGyro = {imu.estMagGyro[0], imu.estMagGyro[1], imu.estMagGyro[2]};
		vector estGyro = {imu.estGyro[0], imu.estGyro[1], imu.estGyro[2]};
		vector estAccGyro16 = estAccGyro;
		vector_divide(&estAccGyro16, 16);
		float roll = radian_add(atan2(estAccGyro.V.x, estAccGyro.V.z), PI);
		float pitch = atan2(estAccGyro.V.y, (estAccGyro.V.z > 0 ? 1 : -1) *sqrt(estAccGyro.V.x*estAccGyro.V.x + estAccGyro.V.z * estAccGyro.V.z));			
		pitch = radian_add(pitch, PI);
		float xxzz = (estAccGyro16.V.x*estAccGyro16.V.x + estAccGyro16.V.z * estAccGyro16.V.z);
		float G = sqrt(xxzz+estAccGyro16.V.y*estAccGyro16.V.y);
		float yaw_est = atan2(estMagGyro.V.z * estAccGyro16.V.x - estMagGyro.V.x * estAccGyro16.V.z,
			(estMagGyro.V.y * xxzz - (estMagGyro.V.x * estAccGyro16.V.x + estMagGyro.V.z * estAccGyro16.V.z) *estAccGyro16.V.y )/G);
		float yaw_gyro = atan2(estGyro.V.z * estAccGyro16.V.x - estGyro.V.x * estAccGyro16.V.z,
			(estGyro.V.y * xxzz - (estGyro.V.x * estAccGyro16.V.x + estGyro.V.z * estAccGyro16.V.z) *estAccGyro16.V.y )/G);


		static double ground_pressure = -1012.9;
		static double ground_temperature = 34.28;

		if (imu.pressure < 10000)
		{
			int pressure = imu.temperature + 0x10000;
			int temp = imu.pressure;

			imu.pressure = pressure;
			imu.temperature = temp;
		}

		double pressure = (imu.pressure)/100.0;

		if (ground_pressure <0 && pressure > 900)
		{
			ground_pressure = pressure;
			ground_temperature = imu.temperature / 100.0;
		}

		double scaling = (double)pressure / ground_pressure;
		double temp = ((double)ground_temperature) + 273.15f;
		double altitude = 153.8462f * temp * (1.0f - exp(0.190259f * log(scaling)));
		double overload = sqrt((double)sensor.accel[0]*sensor.accel[0]+ sensor.accel[1]*sensor.accel[1]+ sensor.accel[2]*sensor.accel[2]) / 2048;
		double throttle = (ppm.in[5]-1000)/520.0;

 		//if (n++ %5 == 0)
 		fprintf(fo, "%.2f,%.2f,%.2f,%2f,%.2f,"
					"%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,"
					"%f,%f,%f,%f,%f,%f,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%f,%f,%f,%d,%d,%d,%d\r\n",
				float(time/1000000.0f), sensor.voltage/1000.0f, sensor.current/1000.0f, overload, altitude,
 				sensor.accel[0], sensor.accel[1], sensor.accel[2], sensor.gyro[0], sensor.gyro[1], sensor.gyro[2], pilot.error[0], pilot.error[1], pilot.error[2], pilot2.I[0], pilot2.D[0],
				roll*180/PI, pitch*180/PI, yaw_gyro*180/PI, pilot.target[0]/100.0, pilot.target[1]/100.0, pilot.target[2]/100.0, 
				(ppm.in[2]-1113)/50, pilot.fly_mode == acrobatic ? 5000 : -5000,
				ppm.in[0], ppm.in[1], ppm.in[2], ppm.in[3], ppm.out[0], ppm.out[1], ppm.out[2], ppm.out[3],
				estAccGyro.V.x, estAccGyro.V.y, estAccGyro.V.z,
				sensor.gyro[0],sensor.gyro[1],sensor.gyro[2], sensor.mag[0]);
// 		fprintf(fo, "%.2f,%d,%d,%d,%d\r\n", float(time/1000000.0f), ppm.in[0], ppm.in[1], ppm.in[2], ppm.in[3]);
// 				// accel[0]前进方向，机尾方向为正
// 				// accel[1]机翼方向，右机翼方向为正
// 				// accel[2]垂直方向，往上为正
				// estAcc[0], 机翼方向，右机翼方向为正
				// estAcc[1], 前进方向，机头方向为正
				// estAcc[2], 垂直方向，往上为正

		if ((rf.time & TAG_MASK) ==  TAG_GPS_DATA)
		fprintf(gpso, "%.2f,%f,%f,%.2f\r\n", float(time/1000000.0f), NDEG2DEG(gps.latitude), NDEG2DEG(gps.longitude), gps.speed/100.0f);
	}

	fclose(gyrof);
	fclose(fo);
	fclose(f);
	fclose(gpso);

	return 0;
}