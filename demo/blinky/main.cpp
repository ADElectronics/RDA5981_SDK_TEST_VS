#include "mbed.h"
#include "rtos.h"

DigitalOut led1(PB_0);
DigitalOut led2(PB_1);

void led2_thread(void const *args) {
    while (true) {
        led2 = !led2;
        Thread::wait(1000);
    }
}

int main() {
    Thread thread(led2_thread);

    while (true) {
        led1 = !led1;
        Thread::wait(500);
    }
}
