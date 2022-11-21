import saito.objloader.*;

// 3D　オブジェクト
OBJModel models[];
final String OBJ_FILE_NAMES[] = {
  "ball_white.obj", "refree.obj", 
  "keeper_red.obj", "player_red.obj", 
  "keeper_blue.obj", "player_blue.obj", 
  "goal_red.obj", "goal_blue.obj"
};


// イベント文字列
final String EVENT_NAMES[] = 
  {
  "", "Kick Off", "Corner Kick", "Goal Kick", "Penalty Kick", 
  "Indirect Free Kick", "Direct Free Kick", "Shoot", "Offside", 
  "Foul", "Throw In"  
};

// ウィンドウ関係パラメータ
final color BACKG_COLOR = color(0, 0, 0);
final int WINDOW_WIDTH = 1200;
final int WINDOW_HEIGHT = 800;

// field parameters　フィールド設定パラメータ
final float FIELD_WIDTH = (64+75)/2.0; 
final float FIELD_LENGTH = (100+110)/2.0; 
final float LINE_WEIGHT = 2.0;
final float PENALTYA_HEIGHT = 40.32;
final float PENALTYA_WIDTH = 16.5; 
final float GOALA_HEIGHT = 18.32;
final float GOALA_WIDTH = 5.5;
final float CENTER_R = 9.15;
final float PENALTYARC_X = 11;
final float CORNER_R = 1;
final float OUTER_WIDTH = 5.0;
final float GOAL_WIDTH = 2.56;
final float GOAL_LENGTH = 7.44;
final int N_STRIPE = 20;
final color FIELD_COLOR1 = color(0, 176, 94);
final color FIELD_COLOR2 = color(0, 156, 74);
final color LINE_COLOR = color(255, 255, 255);
final color LEFT_TEAM_COLOR = color(255, 0, 0);
final color RIGHT_TEAM_COLOR = color(0, 0, 255);
final float FIELD_SCALE_COEFF = 10.0;

// カメラ関係パラメータ
final float CAMERA_ZOOM_UNIT = 10;
final float CAMERA_F = 1;
float camera_p[] = {-150, -FIELD_LENGTH*4, 40 }; //監督からの視点
float focus_p[] = {0.0, 0.0, 0.0};

// 選手・ボール描画パラメータ
final float MODEL_SCALE = 5;
int flame_no = 0;  //フレーム番号

// 時間およびプレイモード関係パラメータ
final int TEXT_X = 150;
final int  TEXT_Y = -200;
final int  TEXT_Z = 350;
final color TIME_C_COLOR = color(255, 255, 255);
final color FLAME_C_COLOR = color(123, 123, 123);
final color BACK_C_COLOR = color(123, 255, 123);
final color PLAY_C_COLOR = color(123, 123, 255);
final color PAUSE_C_COLOR = color(255, 123, 123);
final color FORWARD_C_COLOR = color(255, 123, 255);
final color TEAM_COLOR[] = {color(255, 123, 123), color(123, 123, 255)};
final int MAX_P_SPEED = 64;
final int MIN_P_SPEED = -64;
final int TIME_SKIP = 5*60*1000;
int play_speed = 0;
int play_mode = 0;
int c_millis;
int min_t = 0, max_t = 30000/25*1000;
int tm0=0, tmb=0;// base line
int ms, s, m, h; // times


// キー操作関係パラメータ
boolean shift_flg=false, control_flg=false;

// ファイル＆データ関係
final String DATA_FILE_NAME="data_sample_clean3.csv"; 
String[][] data; 
int N_OBJECT = 29;


// CSVファイル読み込み
boolean readCSV() {
  String lines[] = loadStrings(DATA_FILE_NAME);
  if (lines.length == 0) return false;

  //幅の確認
  int csvWidth = split(lines[0], ',').length;
  for (int i=1; i < lines.length; i++) {
    String[] elements=split(lines[i], ',');
    if (elements.length!=csvWidth) return false;
  }

  //2次元配列の準備
  data = new String [lines.length-1][csvWidth];

  //2次元配列に代入
  for (int i=1; i < lines.length; i++)
    data[i-1]= split(lines[i], ',');

  max_t = 40*(lines.length-2);

  return true;
}

// モデルの描画
void draw_models() {
  draw_players();
  draw_ball();
}


// 選手の描画
void draw_players() {
  // 課題2.2 ～ 2.4　この関数（メソッド）を改造する
  for (int i=0; i<N_OBJECT; i++) {
    float x=0.0, y=0.0;
    if (Integer.parseInt(data[flame_no][7*i+1])==0) {
      if (!data[flame_no][7*i+4].equals("NA") && !data[flame_no][7*i+5].equals("NA")) {
        x = Float.parseFloat(data[flame_no][7*i+4])/100*FIELD_SCALE_COEFF;
        y = Float.parseFloat(data[flame_no][7*i+5])/100*FIELD_SCALE_COEFF;
      }
      if (!data[flame_no][7*i+6].equals("NA") && !data[flame_no][7*i+7].equals("NA")) {
        float vx = Float.parseFloat(data[flame_no][7*i+6])/100*FIELD_SCALE_COEFF;
        float vy = Float.parseFloat(data[flame_no][7*i+7])/100*FIELD_SCALE_COEFF;
        float theta = atan2(vy, vx);
        draw_model(x, y, 0, degrees(theta), 0, 3);
      } else {
        draw_model(x, y, 0, 0.0, 0, 3);//赤チームプレイヤー
      }
    } else if (Integer.parseInt(data[flame_no][7*i+1])==10 && Integer.parseInt(data[flame_no][7*i+3])>=0) {
      if (!data[flame_no][7*i+4].equals("NA") && !data[flame_no][7*i+5].equals("NA")) {
        x = Float.parseFloat(data[flame_no][7*i+4])/100*FIELD_SCALE_COEFF;
        y = Float.parseFloat(data[flame_no][7*i+5])/100*FIELD_SCALE_COEFF;
      }
      if (!data[flame_no][7*i+6].equals("NA") && !data[flame_no][7*i+7].equals("NA")) {
        float vx = Float.parseFloat(data[flame_no][7*i+6])/100*FIELD_SCALE_COEFF;
        float vy = Float.parseFloat(data[flame_no][7*i+7])/100*FIELD_SCALE_COEFF;
        float theta = atan2(vy, vx);
        draw_model(x, y, 0, degrees(theta), 0, 2);
      } else {
        draw_model(x, y, 0, 0.0, 0, 2);//赤チームキーパー
      }
    } else if (Integer.parseInt(data[flame_no][7*i+1])==1 && Integer.parseInt(data[flame_no][7*i+3])>=0) 
    {
      if (!data[flame_no][7*i+4].equals("NA") && !data[flame_no][7*i+5].equals("NA")) {
        x = Float.parseFloat(data[flame_no][7*i+4])/100*FIELD_SCALE_COEFF;
        y = Float.parseFloat(data[flame_no][7*i+5])/100*FIELD_SCALE_COEFF;
      }
      if (!data[flame_no][7*i+6].equals("NA") && !data[flame_no][7*i+7].equals("NA")) {
        float vx = Float.parseFloat(data[flame_no][7*i+6])/100*FIELD_SCALE_COEFF;
        float vy = Float.parseFloat(data[flame_no][7*i+7])/100*FIELD_SCALE_COEFF;
        float theta = atan2(vy, vx);
        draw_model(x, y, 0, degrees(theta), 0, 5);
      } else {
        draw_model(x, y, 0, 180.0, 0, 5);//青チームプレイヤー
      }
    } else if (Integer.parseInt(data[flame_no][7*i+1])==11 && Integer.parseInt(data[flame_no][7*i+3])>=0) 
    {
      if (!data[flame_no][7*i+4].equals("NA") && !data[flame_no][7*i+5].equals("NA")) {
        x = Float.parseFloat(data[flame_no][7*i+4])/100*FIELD_SCALE_COEFF;
        y = Float.parseFloat(data[flame_no][7*i+5])/100*FIELD_SCALE_COEFF;
      }
      if (!data[flame_no][7*i+6].equals("NA") && !data[flame_no][7*i+7].equals("NA")) {
        float vx = Float.parseFloat(data[flame_no][7*i+6])/100*FIELD_SCALE_COEFF;
        float vy = Float.parseFloat(data[flame_no][7*i+7])/100*FIELD_SCALE_COEFF;
        float theta = atan2(vy, vx);
        draw_model(x, y, 0, degrees(theta), 0, 4);
      } else {
        draw_model(x, y, 0, 180.0, 0, 4);//青チームキーパー
      }
    } else if (Integer.parseInt(data[flame_no][7*i+1])==3)
    {
      if (!data[flame_no][7*i+4].equals("NA") && !data[flame_no][7*i+5].equals("NA")) {
        x = Float.parseFloat(data[flame_no][7*i+4])/100*FIELD_SCALE_COEFF;
        y = Float.parseFloat(data[flame_no][7*i+5])/100*FIELD_SCALE_COEFF;
      }
      if (!data[flame_no][7*i+6].equals("NA") && !data[flame_no][7*i+7].equals("NA")) {
        float vx = Float.parseFloat(data[flame_no][7*i+6])/100*FIELD_SCALE_COEFF;
        float vy = Float.parseFloat(data[flame_no][7*i+7])/100*FIELD_SCALE_COEFF;
        float theta = atan2(vy, vx);
        draw_model(x, y, 0, degrees(theta), 0, 1);
      } else {
        draw_model(x, y, 0, 0.0, 0, 1);//審判
      }
    }
  }
}

// ボールの描画
void draw_ball() {
  float x=0.0, y=0.0, z=0.0;
  if (!data[flame_no][204].equals("NA") && !data[flame_no][205].equals("NA") && !data[flame_no][206].equals("NA")) {
    x = Float.parseFloat(data[flame_no][204])/100*FIELD_SCALE_COEFF;
    y = Float.parseFloat(data[flame_no][205])/100*FIELD_SCALE_COEFF;
    z = Float.parseFloat(data[flame_no][206])/100*FIELD_SCALE_COEFF;
    draw_model(x, y, z, 0.0, 0.0, 0);
    focus_p[0] = x; 
    focus_p[1] = y; 
    focus_p[2] = 2;//ボールを画面の中心に
  }


  // 課題2.5　この関数（メソッド）の中身を実装する
}


// 情報の表示
void show_info() {
  pushMatrix();

  // 時間情報の表示 
  fill(TIME_C_COLOR);
  textSize(18);
  text("TIME: "+ nf(h%24, 2)+":"+nf(m%60, 2)+":"+nf(s%60, 2)+":"+nf(ms%1000, 3), TEXT_X, TEXT_Y, TEXT_Z);

  // フレーム情報の表示
  fill(FLAME_C_COLOR);
  textSize(18);
  text("FLAME: "+ data[flame_no][0], TEXT_X, TEXT_Y+20, TEXT_Z);
  //text("FLAME: "+ (flame_no + 1), TEXT_X, TEXT_Y+20, TEXT_Z);

  // プレイモードの表示
  textSize(18);
  if (play_mode==0) {
    fill(PAUSE_C_COLOR);
    text("PAUSE", TEXT_X, TEXT_Y+40, TEXT_Z);
  } else if (play_mode==1) {
    fill(PLAY_C_COLOR);
    text("PLAY", TEXT_X, TEXT_Y+40, TEXT_Z);
  } else if (play_mode==2) {
    fill(FORWARD_C_COLOR);
    text("FORWARD X" + play_speed, TEXT_X, TEXT_Y+40, TEXT_Z);
  } else if (play_mode==3) {
    fill(BACK_C_COLOR);
    text("BACKWARD X" + (-play_speed), TEXT_X, TEXT_Y+40, TEXT_Z);
  }

  // 課題2.6. ここら辺をいじる
  textSize(18);
  int team =  Integer.parseInt(data[flame_no][212]);
  int event = Integer.parseInt(data[flame_no][213]);
  fill(TEAM_COLOR[team]);
  text(EVENT_NAMES[event], TEXT_X, TEXT_Y+60, TEXT_Z);
  popMatrix();
}




// 初期化  
void settings() {
  // ウィンドウの設定
  size(WINDOW_WIDTH, WINDOW_HEIGHT, P3D);
}


void setup() {

  // データの読み込み
  if (!readCSV()) {
    println("データがうまく読み込めません!");
    return;
  }

  // 3Dオブジェクトの読み込み
  models = new OBJModel[OBJ_FILE_NAMES.length];
  for (int i=0; i<OBJ_FILE_NAMES.length; i++) {
    models[i] = new OBJModel(this, OBJ_FILE_NAMES[i]);
    models[i].shapeMode(POLYGON);
  }

  // ウィンドウの設定
  frameRate(60);
  fill(BACKG_COLOR);

  // ライトの設定
  //lights();
  ambientLight(255, 255, 255);
  //directionalLight(255, 255, 255, 0, -1, 0); 
  frustum(-1, 1, -(float)height/width, (float)height/width, 1, 2000);

  //others
  smooth();
}

void draw() {

  background(BACKG_COLOR);
  translate(width/2, height/2);  
  pushMatrix();

  // 時間算出
  c_millis = millis();
  int tm = play_speed*(c_millis-tm0)+tmb; 
  println("tm:" + tm + "  t:" + tm/40);
  if (tm < min_t) { 
    tm0=c_millis; 
    tmb=min_t; 
    tm=min_t; 
    play_mode = 0; 
    play_speed = 0;
  } else if (tm > max_t) { 
    tm0=c_millis; 
    tmb=max_t; 
    tm=max_t; 
    play_mode = 0; 
    play_speed = 0;
  }
  ms=tm;
  s=tm/1000;  
  m=s/60;
  h=m/60;
  flame_no = ms/40;

  // カメラ設定 個別課題はこの辺をいじる
  camera(camera_p[0], -camera_p[1], camera_p[2], focus_p[0], -focus_p[1], focus_p[2], 0.0, 0.0, -1.0);   

  // 描画
  draw_field();
  draw_goals();
  draw_models();

  // drawing models
  /*
  float angle = ms/30;
   for(int i=0; i<models.length-2; i++){
   draw_model(100*cos(radians(angle-20*i)), 100*sin(radians(angle-20*i)), 0, angle-20*i+90, 0, i);
   }
   */

  popMatrix();


  // 情報の表示
  show_info();
}


// キー操作関数群
void set_base_time() {
  tmb = ms; 
  tm0 = c_millis;
}

// ←キー
void rightKeyPressed() {
  switch(play_mode) {
  case 0:
    tmb += 40;
    if (tmb > max_t) { 
      tm0=c_millis; 
      tmb=max_t;
    }
    break;
  case 2:
  case 3:
    if (abs(play_speed)<64) {
      set_base_time();
      play_speed *= 2;
    }
    break;
  }
}

// →キー
void leftKeyPressed() {
  switch(play_mode) {
  case 0:
    tmb -= 40;
    if (tmb > max_t) { 
      tm0=c_millis; 
      tmb=max_t;
    }
    break;
  case 2:
  case 3:
    if (abs(play_speed)>1) {
      set_base_time();
      play_speed /= 2;
    }
    break;
  }
}

// コードキー
void codedKeyPressed() {
  switch(keyCode) {
  case SHIFT:
    shift_flg = true;
    break;     
  case CONTROL:
    control_flg = true;
    break;
  case LEFT:
    leftKeyPressed();
    break;
  case RIGHT:
    rightKeyPressed();
    break;
  }
}

// 文字キー
void uncodedKeyPressed() {
  switch(key) {
  case 's':
    play_mode = 0;
    set_base_time();
    play_speed = 0;
    break;    
  case 'p':
    play_mode = 1;
    set_base_time();
    play_speed = 1;
    break;    
  case 'f': 
    play_mode = 2;
    set_base_time(); 
    play_speed = 1;
    break;   
  case 'b': 
    play_mode = 3;
    set_base_time();
    play_speed = -1; 
    break;
  }
}

void keyPressed() {
  if (key != CODED) uncodedKeyPressed();
  else codedKeyPressed();
}

void keyReleased() {
  if (key == CODED && keyCode == SHIFT) {
    shift_flg = false;
  } else if (key == CODED && keyCode == CONTROL) {
    control_flg = false;
  }
}




// 単一モデル描画関数
void draw_model(float field_x, float field_y, float field_z, float theta, float phi, int id) {
  noStroke();
  pushMatrix();
  //rotateX(PI);
  translate(field_x, -field_y, field_z);
  rotateX(-0.5*PI);
  rotateY(theta/180*PI+0.5*PI);
  rotateX(-phi/180*PI);  
  //lightSpecular(27, 27, 27);  
  //directionalLight(127, 127, 127, 0, 1, 1);    
  scale(MODEL_SCALE);
  models[id].draw();  
  popMatrix();
}

// 弧描画関数
void arc(float x, float y, float r, float theta1, float theta2) {
  float delta = (theta2-theta1)/360;
  float sangle = theta1;
  float sx, sy; 
  float ex = r*cos(sangle)+x;
  float ey = r*sin(sangle)+y;
  for (int i=1; i<360; i++) {
    sx = ex;  
    sy = ey;
    sangle += delta;
    ex = r*cos(sangle)+x;
    ey = r*sin(sangle)+y;       
    line(sx, sy, ex, ey);
  }
}

// ゴール描画関数
void draw_goals() { 
  draw_model(-0.5*FIELD_SCALE_COEFF*FIELD_LENGTH, 0, 0, 0, 0, 6);
  pushMatrix();
  rotateZ(PI);  
  draw_model(-0.5*FIELD_SCALE_COEFF*FIELD_LENGTH, 0, 0, 0, 0, 7);
  popMatrix();
}

// フィールド描画関数
void draw_field() {

  float field_length = FIELD_SCALE_COEFF*FIELD_LENGTH;
  float field_width = FIELD_SCALE_COEFF*FIELD_WIDTH;    
  float corner_x = -0.5*field_length;
  float corner_y = -0.5*field_width;

  float arc_r =  FIELD_SCALE_COEFF*CENTER_R;
  float arc_theta = acos((PENALTYA_WIDTH-PENALTYARC_X)/CENTER_R);


  rectMode(CORNER);    

  //外側
  noStroke();  
  float w = OUTER_WIDTH*FIELD_SCALE_COEFF;
  float lw  = (field_length + 2*w)/N_STRIPE;
  for (int i=0; i<N_STRIPE; i++) {
    if (i%2==0) fill(FIELD_COLOR1);
    else fill(FIELD_COLOR2);
    rect(corner_x-w+i*lw, corner_y-w, lw, field_width+2*w);
  }
  strokeWeight(LINE_WEIGHT);
  stroke(LINE_COLOR);
  noFill();

  // タッチライン, センターライン, センターサークル
  rect(corner_x, corner_y, field_length, field_width);   
  rect(corner_x, corner_y, 0.5 * field_length, field_width);
  ellipse(0, 0, FIELD_SCALE_COEFF * 2 * CENTER_R, FIELD_SCALE_COEFF * 2 * CENTER_R);

  // 左側ゴールエリア，ペナルティエリア
  arc(corner_x+FIELD_SCALE_COEFF*PENALTYARC_X, 0, arc_r, arc_theta, -arc_theta);
  rect(corner_x, -0.5*FIELD_SCALE_COEFF*PENALTYA_HEIGHT, FIELD_SCALE_COEFF*PENALTYA_WIDTH, FIELD_SCALE_COEFF*PENALTYA_HEIGHT);  
  rect(corner_x, -0.5*FIELD_SCALE_COEFF*GOALA_HEIGHT, FIELD_SCALE_COEFF*GOALA_WIDTH, FIELD_SCALE_COEFF*GOALA_HEIGHT);  

  //　左側コーナーマーク
  arc(corner_x, corner_y, FIELD_SCALE_COEFF*CORNER_R, 0, PI/2.0);
  arc(corner_x, -corner_y, FIELD_SCALE_COEFF*CORNER_R, -PI/2.0, 0);  

  //　右側ゴールエリア，ペナルティエリア
  pushMatrix();
  rotateZ(PI);
  arc(corner_x + FIELD_SCALE_COEFF * PENALTYARC_X, 0, arc_r, arc_theta, -arc_theta);
  rect(corner_x, -0.5*FIELD_SCALE_COEFF*PENALTYA_HEIGHT, FIELD_SCALE_COEFF*PENALTYA_WIDTH, FIELD_SCALE_COEFF*PENALTYA_HEIGHT);  
  rect(corner_x, -0.5*FIELD_SCALE_COEFF*GOALA_HEIGHT, FIELD_SCALE_COEFF*GOALA_WIDTH, FIELD_SCALE_COEFF*GOALA_HEIGHT);  

  //　右側コーナーマーク
  arc(corner_x, corner_y, FIELD_SCALE_COEFF*CORNER_R, 0, PI/2.0);
  arc(corner_x, -corner_y, FIELD_SCALE_COEFF*CORNER_R, -PI/2.0, 0);  


  popMatrix();
}
