class Circle
{
  
  float x;
  float y;
  float r;
  int source, position;
  String theWord;

  
  Circle(float x_, float y_, float r_, int source_, String theWord_, int position_){
    x = x_;
    y = y_;
    r = r_;
    source = source_;
    theWord = theWord_;
    position = position_;
  }
  
  void show(){
    stroke(0);
    strokeWeight(1);
    if (source == 2) fill(255, 55, 0); else fill (0, 55, 255);
    ellipse(x, y, r, r);
    if (source == 2) fill(#F5B4B4); else fill (0, 180, 255);
    textSize(r/3.5);
    text(theWord, x-r/2+r/10, y+r/13);
    //text(position, x-r/2+r/10, y+r/13);
  }
}
