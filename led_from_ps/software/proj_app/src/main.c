#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "sleep.h"
#define LED 0x01
#define GPIO_EXAMPLE_DEVICE_ID  XPAR_U1_LED_GPIO_DEVICE_ID
#define LED_DELAY     1000000
#define LED_CHANNEL 1
XGpio Gpio; /* The Instance of the GPIO Driver */
int main(void)
{
   int Status;
   Status = XGpio_Initialize(&Gpio, GPIO_EXAMPLE_DEVICE_ID);
   if (Status != XST_SUCCESS) {
       xil_printf("Gpio Initialization Failed\r\n");
       return XST_FAILURE;
   }
/* Set the direction for all signals as inputs except the LED output */
   XGpio_SetDataDirection(&Gpio, LED_CHANNEL, 0x0);
   /* Loop forever blinking the LED */
   while (1) {
       /* Set the LED to High */
       XGpio_DiscreteWrite(&Gpio, LED_CHANNEL, 0x0);
       /* Wait a small amount of time so the LED is visible */
       usleep(LED_DELAY);
       /* Clear the LED bit */
       XGpio_DiscreteClear(&Gpio, LED_CHANNEL, 0x1);
       /* Wait a small amount of time so the LED is visible */
       usleep(LED_DELAY);
   }
}
