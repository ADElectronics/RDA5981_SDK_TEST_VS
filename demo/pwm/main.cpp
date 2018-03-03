#include "mbed.h"
#include "rtos.h"

PwmOut pwm0(PB_0); // GPIO_PIN0

int main() 
{
	float pwm = 0.0f;

    pwm0.period_ms(1.0f);
    pwm0.write(pwm);

    while(true) 
	{       
        Thread::wait(1000);

		pwm += 0.01f;
		if (pwm > 1.0f) pwm = 0.0f;
		pwm0.write(pwm);

		printf("PWM duty=%f\r\n", pwm0.read());
    }
}
