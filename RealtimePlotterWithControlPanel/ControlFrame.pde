// Settings for the control panel are saved in this file
JSONObject robotConfigJSON;


ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;

  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);

    robotConfigJSON = loadJSONObject(topSketchPath+"/robot_config.json");
    //printArray(json.getJSONObject("sensors2").getJSONObject("1"));

    // speed PID
    int x;
    int y;
    cp5.addTextlabel("label").setText("Speed PID (outer loop)").setPosition(x=5, y=5).setFont(createFont("Georgia", 12));
    cp5.addTextfield("speed-PID Kp").setPosition(x=x+5, y=y+20).setText(getConfigString("speedPIDKp")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("speed-PID Ki").setPosition(x, y=y+40).setText(getConfigString("speedPIDKi")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("speed-PID Kd").setPosition(x, y=y+40).setText(getConfigString("speedPIDKd")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("speed-PID Output LowerLimit").setPosition(x, y=y+60).setText(getConfigString("speedPIDOutputLowerLimit")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("speed-PID Output HigherLimit").setPosition(x, y=y+40).setText(getConfigString("speedPIDOutputHigherLimit")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("speed-PID Sampling").setPosition(x, y=y+40).setText(getConfigString("speedPIDSampling")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("motor Speed SensorSampling").setPosition(x, y=y+40).setText(getConfigString("motorSpeedSensorSampling")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("speed Kalman FilterR").setPosition(x, y=y+40).setText(getConfigString("speedKalmanFilterR")).setWidth(40).setAutoClear(false);

    // angple PID
    x = x+150;
    y = 5;
    cp5.addTextlabel("Angle PID (outer loop)").setText("Angle PID (outer loop)").setPosition(x, y).setFont(createFont("Georgia", 12));
    x = x + 5;
    y = y+20;
    cp5.addTextlabel("Conservative").setText("Conservative").setPosition(x, y).setFont(createFont("Georgia", 12));
    x = x + 100;
    cp5.addTextlabel("Aggressive").setText("Aggressive").setPosition(x, y).setFont(createFont("Georgia", 12));
    x = x - 95;
    y = y+20;
    cp5.addTextfield("angle-PID ConKp").setPosition(x, y).setText(getConfigString("anglePIDConKp")).setWidth(40).setAutoClear(false);
    x = x + 100;
    cp5.addTextfield("angle-PID AggKp").setPosition(x, y).setText(getConfigString("anglePIDAggKp")).setWidth(40).setAutoClear(false);
    x = x - 100;
    y = y+40;
    cp5.addTextfield("angle-PID ConKi").setPosition(x, y).setText(getConfigString("anglePIDConKi")).setWidth(40).setAutoClear(false);
    x = x + 100;
    cp5.addTextfield("anglePIDAggKi").setPosition(x, y).setText(getConfigString("anglePIDAggKi")).setWidth(40).setAutoClear(false);
    x = x - 100;
    y = y+40;
    cp5.addTextfield("angle-PID ConKd").setPosition(x, y).setText(getConfigString("anglePIDConKd")).setWidth(40).setAutoClear(false);
    x = x + 100;
    cp5.addTextfield("angle-PID AggKd").setPosition(x, y).setText(getConfigString("anglePIDAggKd")).setWidth(40).setAutoClear(false);

    // angle general      
    cp5.addTextfield("angle-PID LowerLimit").setPosition(x=x-100, y=y+60).setText(getConfigString("anglePIDLowerLimit")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("calibrated Zero Angle").setPosition(x, y=y+40).setText(getConfigString("calibratedZeroAngle")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("angle-PID Sampling").setPosition(x, y=y+40).setText(getConfigString("anglePIDSampling")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("angle Sensor Sampling").setPosition(x, y=y+40).setText(getConfigString("angleSensorSampling")).setWidth(40).setAutoClear(false);
    cp5.addTextfield("angle Kalman FilterR").setPosition(x, y=y+40).setText(getConfigString("angleKalmanFilterR")).setWidth(40).setAutoClear(false);

    // Debug
    cp5.addTextlabel("Debug").setText("Debug").setPosition(x=x+200, y=5).setFont(createFont("Georgia", 12));
    cp5.addToggle("debug Level").setPosition(x, y=y+40).setValue(int(getConfigString("debugLevel"))).setMode(ControlP5.SWITCH);
    cp5.addTextfield("debug Sample Rate").setPosition(x, y=y+40).setText(getConfigString("debugSampleRate")).setWidth(40).setAutoClear(false);
    cp5.addToggle("speed-PID OutputDebug").setPosition(x, y=y+40).setValue(int(getConfigString("speedPIDOutputDebug"))).setMode(ControlP5.SWITCH);
    cp5.addToggle("speed-PID InputDebug").setPosition(x, y=y+40).setValue(int(getConfigString("speedPIDInputDebug"))).setMode(ControlP5.SWITCH);
    cp5.addToggle("speed Kalman FilterDebug").setPosition(x, y=y+40).setValue(int(getConfigString("speedKalmanFilterDebug"))).setMode(ControlP5.SWITCH);
    cp5.addToggle("angle-PID SetpointDebug").setPosition(x, y=y+40).setValue(int(getConfigString("anglePIDSetpointDebug"))).setMode(ControlP5.SWITCH);
    cp5.addToggle("angle-PID InputDebug").setPosition(x, y=y+40).setValue(int(getConfigString("anglePIDInputDebug"))).setMode(ControlP5.SWITCH);
    cp5.addToggle("angle-PID OutputDebug").setPosition(x, y=y+40).setValue(int(getConfigString("anglePIDOutputDebug"))).setMode(ControlP5.SWITCH);
    cp5.addToggle("speed RawDebug").setPosition(x, y=y+40).setValue(int(getConfigString("speedRawDebug"))).setMode(ControlP5.SWITCH);
    cp5.addToggle("angle RawDebug").setPosition(x, y=y+40).setValue(int(getConfigString("angleRawDebug"))).setMode(ControlP5.SWITCH);

    PImage[] imgs = {
      loadImage(topSketchPath+"/images/button_a.png"), loadImage(topSketchPath+"/images/button_b.png"), loadImage(topSketchPath+"/images/button_c.png")
    };
    
    x = 200;
    cp5.addButton("moveForwards").setValue(1).setPosition(x, y=y+60).setImages(imgs).updateSize();
    cp5.addButton("moveBackwards").setValue(1).setPosition(x, y=y+60).setImages(imgs).updateSize();
    cp5.addButton("turnLeft").setValue(1).setPosition(x=x-60, y).setImages(imgs).updateSize();
    cp5.addButton("turnRight").setValue(1).setPosition(x=x+120, y).setImages(imgs).updateSize();
    
    cp5.addButton("start").setValue(1).setPosition(x=x-250, y=y-60);
    cp5.addButton("stop").setValue(1).setPosition(x, y=y+40);
    cp5.addButton("calibrate").setValue(1).setPosition(x, y=y+40);
  }



  void controlEvent(ControlEvent theEvent) {
    print(theEvent);
    if (theEvent.isAssignableFrom(Textfield.class) || theEvent.isAssignableFrom(Toggle.class) || theEvent.isAssignableFrom(Button.class)) {
      String parameter = theEvent.getName();
      String value = "";
      if (theEvent.isAssignableFrom(Textfield.class))
        value = theEvent.getStringValue();
      else if (theEvent.isAssignableFrom(Toggle.class) || theEvent.isAssignableFrom(Button.class))
        value = theEvent.getValue()+"";

      robotConfigJSON.setString(parameter, value);
      saveJSONObject(robotConfigJSON, topSketchPath+"/robot_config.json");
      if (!mockupSerial) {
        serialPort.write("set "+parameter+" "+value+";");
        serialPort.clear();
      }
      print("set "+parameter+" "+value+";\n");
      /*for (int i=0; i<inBuffer.length; i++) {
       inBuffer[i] = 0;  
       }*/
    }
  }

  public void draw() {
    background(abc);
  }

  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }


  ControlP5 cp5;

  Object parent;
}
String getConfigString(String id) {
  String r = "";
  try {
    r = robotConfigJSON.getString(id);
  } 
  catch (Exception e) {
    r = "";
  }
  return r;
}

