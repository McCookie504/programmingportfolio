class Button {
  // Member Variables
  float x, y, w, h;
  color c1, c2;
  char val;
  boolean hover;

  // Constuctor
  Button(float x, float y, char val, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    h = 40;
    c1 = color(#7FC9FC);
    c2 = color(#FCC97E);
    this.val = val;
    hover = false;
  }

  // Member Methods
  void display() {
    textAlign(CENTER);
    rectMode(CENTER);
    if (hover == true) {
      fill(c2);
    } else {
      fill(c1);
    }
    rect(x, y, w, h, 10);
    fill(255);
    text(val, x, y);
  }

  void mouseOver(float tempX, float tempY) {
    if (tempX > x-w/2 && tempX < x+w/2 && tempY > y-h/2 && tempY < y+h/2) {
      hover = true;
    } else {
      hover = false;
    }
  }
}
