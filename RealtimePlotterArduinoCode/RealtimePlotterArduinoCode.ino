uint8_t buffer[20]; //Buffer needed to store data packet for transmission
int16_t data1 = 1;
int16_t data2 = 2;
int16_t data3 = 3;
int16_t data4 = 4;
bool debug = false;

uint8_t buffer2[20];

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
}

int16_t value = 0;
int8_t direction = 10;
void loop() {
  // put your main code here, to run repeatedly: 
  //Serial.write(value);
  value = (value + direction);
  if (value > 100)
    direction = -10;
  else if (value < -50)
    direction = 10;
  //data3 = value;
  //plot(value, value/2, value/4, value/8);
  for (uint8_t i = 0; i<7; i++) {
    switch (i) {
      case 0:
      Serial.print(value);
      break;
      case 1:
      Serial.print(value/2);
      break;
      case 2:
      Serial.print(value/4);
      break;
      case 3:
      Serial.print(value/8);
      break;
      case 4:
      Serial.print(value/16);
      break;
      case 5:
      Serial.print(value/32);
      break;
    }
    if (i < 7)
      Serial.print(" ");
  }
  Serial.print('\r');
  delay(5);
}
uint8_t variableA = {0x00};
void plot(int16_t data1, int16_t data2, int16_t data3, int16_t data4) {
  int16_t pktSize;
  
  buffer[0] = 0xCDAB;             //SimPlot packet header. Indicates start of data packet
  //buffer[1] = 4*sizeof(int16_t);      //Size of data in bytes. Does not include the header and size fields
  buffer[1] = 1;
  buffer[2] = 5;
  buffer[3] = 6;
  buffer[4] = 7;
  buffer[5] = 8;
    
  pktSize = 2 + 2 + (4*sizeof(int16_t)); //Header bytes + size field bytes + data
  
  if (!debug) {
    Serial.print(data1);
    Serial.print(" ");
    Serial.print(data2);
    Serial.print(" ");
    Serial.print(data3);
    Serial.print(" ");
    Serial.print(data4);
    Serial.print('\r');
  }
  else {
    Serial.print("Size: ");
    Serial.println(pktSize, HEX);
    for (int i = 0; i<pktSize; i++) {
      Serial.print(buffer[i], HEX);
      Serial.print(" ");
    }
    Serial.println();
  }
}
