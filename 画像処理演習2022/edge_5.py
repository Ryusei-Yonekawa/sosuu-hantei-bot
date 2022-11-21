# coding: utf-8 

import cv2

def mosaic(img, scale=0.1):
    h, w = img.shape[:2]  # �摜�̑傫��

    # �摜�� scale (0 < scale <= 1) �{�ɏk������B
    dst = cv2.resize(
        img, dsize=None, fx=scale, fy=scale, interpolation=cv2.INTER_NEAREST
    )

    # ���̑傫���Ɋg�傷��B
    dst = cv2.resize(dst, dsize=(w, h), interpolation=cv2.INTER_NEAREST)

    return dst

for num in range(257):
        s = str(num).zfill(3)
        img = cv2.imread('./images3/img_%s.bmp'%s)
  
        cascade_file = "haarcascade_frontalface_alt2.xml"
        cascade = cv2.CascadeClassifier(cascade_file)


        face_list = cascade.detectMultiScale(img, scaleFactor=1.1, minNeighbors=1, minSize=(1, 1))
	
        for (x, y, w, h) in face_list:
            border_color = (0, 0, 255)
 
            border_size = 2
            
            roi = img[y : y + h, x : x + w]
            roi[:] = mosaic(roi)

        cv2.imwrite('./output_4/img_%s.bmp'%s, img)

