#include <LiquidCrystal.h>

LiquidCrystal lcd(22, 23, 24, 25, 26, 27);

byte customChar[] = {
  B00100,
  B01110,
  B11111,
  B01110,
  B01110,
  B01110,
  B01110,
  B00000
};

void setup() {
  // put your setup code here, to run once:
  lcd.begin(16, 2);
  lcd.setCursor(0, 1);
  lcd.print("hola mundo");
  lcd.createChar(0, customChar);
  lcd.setCursor(0, 0);
  lcd.write(byte(0));
}

void loop() {
  // put your main code here, to run repeatedly:
  
}
