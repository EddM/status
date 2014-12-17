const boolean RED[] = { HIGH, LOW, LOW };
const boolean GREEN[] = { LOW, HIGH, LOW };
const boolean YELLOW[] = { HIGH, HIGH, LOW };
const boolean OFF[] = { LOW, LOW, LOW };

// set of 3 pin IDs for (in order) red, green and blue cathodes
int led[] = { 0, 1, 2 };

void setup() {
  pinMode(led[0], OUTPUT);
  pinMode(led[1], OUTPUT);
  pinMode(led[2], OUTPUT);
  setColor(led, OFF);

  Spark.function("setOK", setOK);
  Spark.function("setError", setError);
}

void loop() {
}

int setOK(String cmd) {
  setColor(led, GREEN);
  return 1;
}

int setError(String cmd) {
  setColor(led, RED);
  return 1;
}

int setUnknown(String cmd) {
  setColor(led, YELLOW);
  return 1;
}

void setColor(int* pins, const boolean* color) {
  for(int i = 0; i < 3; i++){
    digitalWrite(led[i], !color[i]);
  }
}
