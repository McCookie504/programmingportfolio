// Adam McConkie | 9/14/26 | Calculator
// Color palette: #7FC9FC (light blue) #FCC97E (pale yellow) #8EAABD (blue-gray) #A79C8C (gray-brown) #64737D (blue-gray)
String displayVal;
float l, r, result;
char op;
boolean left;
boolean newEntry;
Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];

void setup() {
  size(300, 440);
  displayVal = "0.0";
  l = 0.0;
  r = 0.0;
  result = 0.0;
  op = ' ';
  left = true;
  newEntry = true;
  numButtons[0] = new Button(60, 280, '0', 40);
  numButtons[1] = new Button(60, 100, '1', 40);
  numButtons[2] = new Button(120, 100, '2', 40);
  numButtons[3] = new Button(180, 100, '3', 40);
  numButtons[4] = new Button(60, 160, '4', 40);
  numButtons[5] = new Button(120, 160, '5', 40);
  numButtons[6] = new Button(180, 160, '6', 40);
  numButtons[7] = new Button(60, 220, '7', 40);
  numButtons[8] = new Button(120, 220, '8', 40);
  numButtons[9] = new Button(180, 220, '9', 40);

  opButtons[0] = new Button(240, 100, '+', 40);
  opButtons[1] = new Button(240, 160, '-', 40);
  opButtons[2] = new Button(240, 220, 'x', 40);
  opButtons[3] = new Button(240, 280, '÷', 40);
  opButtons[4] = new Button(120, 280, '.', 40);
  opButtons[5] = new Button(180, 280, '±', 40);
  opButtons[6] = new Button(60, 340, ' ', 40);
  opButtons[7] = new Button(120, 340, '^', 40);
  opButtons[8] = new Button(180, 340, ' ', 40);
  opButtons[9] = new Button(240, 340, ' ', 40);
  opButtons[10] = new Button(90, 400, 'C', 100);
  opButtons[11] = new Button(210, 400, '=', 100);
}

void draw() {
  background(#64737D);
  updateDisplay();
  for (int i = 0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].mouseOver(mouseX, mouseY);
  }
  for (int i = 0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].mouseOver(mouseX, mouseY);
  }
}

void updateDisplay() {
  // Background shape
  rectMode(CENTER);
  rect(150, 40, 260, 40, 10);

  //Overlay text
  fill(0);
  textAlign(RIGHT);
  textSize(20);
  text(displayVal, width-30, 45);
}

void mouseReleased() {
  // Update display with proper button mouse click
  for (int i = 0; i < numButtons.length; i++) {
    numButtons[i].mouseOver(mouseX, mouseY);
  }
  for (int i = 0; i < opButtons.length; i++) {
    opButtons[i].mouseOver(mouseX, mouseY);
  }
  //Number Buttons
  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover == true) {
      handleEvent(numButtons[i].val, true);
    }
  }

  //Operator Buttons
  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover) {
      char clicked = opButtons[i].val;

      if (clicked == '=') {
        performCalc();
      } else if (clicked == 'C') {
        // reset all variables
        displayVal = "0.0";
        l = 0.0;
        r = 0.0;
        result = 0.0;
        op = ' ';
        left = true;
        newEntry = true;
      } else if (clicked == '^') {
        if (left == true) {
          l = sq(l);
          displayVal = str(l);
        } else {
          r = sq(r);
          displayVal = str(r);
        }
      } else if (clicked == '+' || clicked == '-' ||
        clicked == 'x' || clicked == '÷') {
        op = clicked;
        left = false;
        newEntry = true;
        displayVal = str(op);
      } else if (clicked == '±') {
        //toggleSign();
      } else if (clicked == '.') {
        if (displayVal.contains(".") == false) {
          if (left == true) {
            displayVal += ".";
            l = float(displayVal);
          } else {
            displayVal += ".";
            r = float(displayVal);
          }
        }
      }
    }
  }
}

void performCalc() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '÷') {
    if (r == 0) {
      displayVal = "ERROR";
      newEntry = true;
      return;
    }
    result = l / r;
  } else if (op == 'x') {
    result = l * r;
  } else {
    return;
  }

  displayVal = str(result);
  l = result;
  r= 0.0;
  left = true;
  newEntry = true;
}

void keyPressed() {
  if (key == '1') {
    println("You hit 1 " + keyCode);
    handleEvent('1', true);
  } else if (key == '2') {
    println("You hit 2 " + keyCode);
    handleEvent('2', true);
  } else if (key == '3') {
    println("You hit 3 " + keyCode);
    handleEvent('3', true);
  }
}

void handleEvent(char val, boolean isNum) {
  if (isNum == true) {
    String digit = str(val);

    if (newEntry || displayVal.equals("0.0")) {
      displayVal = digit;
      newEntry = false;
    } else {
      displayVal += digit;
    }

    if (left) {
      l = float(displayVal);
    } else {
      r = float(displayVal);
    }
  } else {
    // other stuff
  }
}
