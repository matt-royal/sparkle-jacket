#include <Adafruit_NeoPixel.h>

#define PIN 6

// Parameter 1 = number of pixels in strip
// Parameter 2 = pin number (most are valid)
// Parameter 3 = pixel type flags, add together as needed:
//   NEO_RGB     Pixels are wired for RGB bitstream
//   NEO_GRB     Pixels are wired for GRB bitstream
//   NEO_KHZ400  400 KHz bitstream (e.g. FLORA pixels)
//   NEO_KHZ800  800 KHz bitstream (e.g. High Density LED strip)
Adafruit_NeoPixel strip = Adafruit_NeoPixel(14, PIN, NEO_GRB + NEO_KHZ800);

void setup() {
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
  strip.setBrightness(40);
  Serial.begin(9600);
}

uint32_t off = 0;

uint32_t red = strip.Color(255, 0, 0);

uint32_t orangeRed = strip.Color(255, 69, 0);
uint32_t orange = strip.Color(255,165,0);

uint32_t crimson = strip.Color(220,20,60);
uint32_t lightSalmon = strip.Color(255,160,122);
uint32_t hotPink = strip.Color(255,105,180); //peach
uint32_t deepPink = strip.Color(255,20,147);

uint32_t green = strip.Color(0, 255, 0);
uint32_t darkGreen = strip.Color(0, 100, 0);
uint32_t lawnGreen = strip.Color(124,252,0);

uint32_t blue = strip.Color(0, 0, 255);
uint32_t aqua = strip.Color(0, 255, 255);
uint32_t springGreen = strip.Color(0, 255, 127);

uint32_t magenta = strip.Color(255, 0, 255);
uint32_t brightPurple = strip.Color(204, 0, 204); // not from the chart
uint32_t purple = strip.Color(128,0,128);
uint32_t darkOrchid = strip.Color(153,50,204);

uint32_t yellow = strip.Color(255, 255, 0);
uint32_t gold = strip.Color(255, 215, 0);

void loop() {
  // Some example procedures showing how to display to the pixels:
//  chasingDots(500);
//  starField();
  uint32_t allOff[14] = {off, off, off, off, off, off, off, off, off, off, off, off, off, off};
  uint32_t allRed[14] = {red, red, red, red, red, red, red, red, red, red, red, red, red, red};
  uint32_t allGreen[14] = {green, green, green, green, green, green, green, green, green, green, green, green, green, green};
  uint32_t allBlue[14] = {blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue};
  /* drawLapel(strip, allOff, 100); */
  /* drawLapel(strip, allRed, 100); */
  /* drawLapel(strip, allGreen, 100); */
  /* drawLapel(strip, allBlue, 100); */

  /* uint32_t poleColors[3] = {aqua, springGreen, brightPurple}; */
  /* uint32_t poleColors[3] = {green, lawnGreen, darkGreen}; */
  /* animateBarberPole(poleColors, 3, 1000); */

  /* uint32_t colors[1] = {darkOrchid}; */
  /* animateBarberPole(colors, 1, 1000); */

  uint32_t colors[] = {red, orange, yellow, green, blue, purple};
  animateBarberPole(colors, 6, 1000);

  /* colorWipe(strip.Color(255, 0, 0), 50); // Red */
  /* colorWipe(strip.Color(0, 255, 0), 50); // Green */
  /* colorWipe(strip.Color(0, 0, 255), 50); // Blue */
  /* rainbow(20); */
  /* rainbowCycle(20); */
}


void animateBarberPole(uint32_t colors[], uint16_t numOfColors, uint8_t wait) {
  for (uint8_t i=0; i < numOfColors; i++) {
    uint16_t firstIndex = numOfColors-i-1;
    uint32_t color1 = colors[firstIndex];
    uint32_t color2 = colors[(firstIndex+1)%numOfColors];
    uint32_t color3 = colors[(firstIndex+2)%numOfColors];
    uint32_t color4 = colors[(firstIndex+3)%numOfColors];
    uint32_t color5 = colors[(firstIndex+4)%numOfColors];
    uint32_t frame[14] = {color1, color1, color2, color2, color2, color3, color3, color3, color4, color4, color4, color5, color5, color5};
    drawLapel(strip, frame, wait);
  }
};


void drawLapel(Adafruit_NeoPixel strip, uint32_t* animationCell, uint8_t wait) {
  for(uint16_t i=0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, animationCell[i]);
  }
  strip.show();
  delay(wait);
};


/* void animateLapel(Adafruit_NeoPixel strip, uint32_t*[14] animationCells, uint8_t wait) { */
  /* uint32_t numberOfCells = sizeof(animationCells)/sizeof(uint32_t); */
  /* for(uint16_t i=0; i < numberOfCells; i++) { */
    /* uint32_t currentCell[14] = animationsCells[i]; */
    /* drawLapel(strip, currentCell, wait); */
  /* } */
/* }; */

void chasingDots(uint8_t wait) {
  for(uint16_t i=0; i < strip.numPixels(); i++) {
    for(uint16_t j=0; i < strip.numPixels(); j++) {
      if(j != i && j != i+1) {
        strip.setPixelColor(j, 0);
      }
    };
    strip.setPixelColor(i, strip.Color(255, 255, 255));
    if (i+1 < strip.numPixels()) {
      strip.setPixelColor(i+1, strip.Color(255, 255, 255));
    }
    strip.show();
    delay(wait);
  }
};

void starField() {
  for(uint16_t j=0; j < 50; j++) {
  uint16_t pixelIsLit;
  for(uint16_t i=0; i < strip.numPixels(); i++) {
    if( random(0, 2) == 1 ) {
      strip.setPixelColor(i, strip.Color(255, 255, 255));
    }
    else {
      strip.setPixelColor(i, 0);
    }
  };
  strip.show();
  delay(500);
  }
};

// Fill the dots one after the other with a color
void colorWipe(uint32_t c, uint8_t wait) {
  for(uint16_t i=0; i<strip.numPixels(); i++) {
      strip.setPixelColor(i, c);
      strip.show();
      delay(wait);
  }
}

void rainbow(uint8_t wait) {
  uint16_t i, j;

  for(j=0; j<256; j++) {
    for(i=0; i<strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel((i+j) & 255));
    }
    strip.show();
    delay(wait);
  }
}

// Slightly different, this makes the rainbow equally distributed throughout
void rainbowCycle(uint8_t wait) {
  uint16_t i, j;

  for(j=0; j<256*5; j++) { // 5 cycles of all colors on wheel
    for(i=0; i< strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel(((i * 256 / strip.numPixels()) + j) & 255));
    }
    strip.show();
    delay(wait);
  }
}

// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos) {
  if(WheelPos < 85) {
   return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
  } else if(WheelPos < 170) {
   WheelPos -= 85;
   return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  } else {
   WheelPos -= 170;
   return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
}

