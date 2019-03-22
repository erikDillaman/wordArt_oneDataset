ArrayList<Circle> circles;
Table t1;
float scale = 15;  // set the drawing size
int iterations = 8000;
int count = 0; 
int circleIndex = 0;
boolean theEnd = false;

void setup()
{
  size(2000, 1400);
  circles = new ArrayList<Circle>();
  t1 = loadTable("MSNDOutputFile.csv");
  colorMode(HSB);
}


void draw()
{
  noLoop();  
  background(0);
  int attempts = 0; 

  for (int i = 1; i < iterations; i++) {
    boolean foundOne = false;
    boolean foundTwo = false;

    while (!theEnd && !foundOne && attempts < 1000) {
      Circle newC1 = newCircle(t1.getString(i, 0), t1.getInt(i, 1), 1, i);
      if (newC1 != null) {
        circles.add(newC1);
        foundOne = true;
      }
      if (theEnd) break;
      attempts++;
    }

    if (theEnd || attempts >= 1000) {
      println("Total circles: "+circles.size());
      println("FINISHED");
      break;
    }
  }

  for (Circle c : circles) {
    c.show();
  }
}


Circle newCircle(String word, int freq, int source, int position)
{

  float x = width/2; 
  float y = height/2;  
  float r = int((freq/scale));
  if (r < 10) r = 10;
  float d = 0;

  boolean valid = true;

  if (count > 0) {
    Circle circ = circles.get(circleIndex);

    for (int i = 0; i < 360; i++) {
      x = circ.x+(circ.r/2+r/2)*cos(i*PI/180);
      y = circ.y+(circ.r/2+r/2)*-sin(i*PI/180);
      for (Circle c : circles) {
        d = dist(x, y, c.x, c.y);
        if ((d < (c.r/2+r/2)) || outsideEdges(x, y, r/2)) {
          valid = false;
          break;
        }
      }
      if (valid) {
        break;
      } else {
        if (circleIndex < circles.size()-1 && i >= 359) {
          circleIndex++;
          valid = false;
          break;
        } else if (circleIndex == circles.size()-1 && i >= 359) {
          theEnd = true;
          valid = false;
          break;
        }
        valid = true;
      }
    }
  }

  if (valid || count < 1) {
    count ++;
    return new Circle(x, y, r, source, word, position);
  } else {
    return null;
  }
}

boolean outsideEdges(float x, float y, float r)
{
  return (x+r > width || x-r < 0 || y+r > height || y-r < 0);
}
