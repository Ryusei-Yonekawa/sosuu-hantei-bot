# coding: utf-8
import cv2
import os

output_dirpath = "./output_3"

# VideoCapture を作成する。
img_path = os.path.join(output_dirpath, 'img_%03d.bmp')  # 画像ファイルのパス
print(img_path)
#cap = cv2.VideoCapture(img_path)

i=1
img_path = os.path.join(output_dirpath, 'img_%03d.bmp' % i) 
# 画像の大きさを取得
frame = cv2.imread(img_path,cv2.IMREAD_COLOR)
height, width, tmp = frame.shape[:3]


# フレームレートを設定
fps = 25 
print('width: {}, height: {}, fps: {}'.format(width, height, fps))

# VideoWriter を作成する。
fourcc = cv2.VideoWriter_fourcc(*'DIVX')
writer = cv2.VideoWriter('kadai2.mp4', fourcc, fps, (width, height))


while True:
   # 1フレームずつ取得する。
   img_path = os.path.join(output_dirpath, 'img_%03d.bmp' % i)  # 画像ファイルのパス
   frame = cv2.imread(img_path)

   if frame is None:
      break  # 映像取得に失敗
   
   writer.write(frame)  # フレームを書き込む。
   i = i + 1

writer.release()

