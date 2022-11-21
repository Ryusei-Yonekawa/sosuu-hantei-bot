# coding: utf-8 

import cv2



for num in range(257):
        s = str(num).zfill(3)
        img = cv2.imread('./images/img_%s.bmp'%s)
  
        cascade_file = "haarcascade_frontalface_alt2.xml"
        cascade = cv2.CascadeClassifier(cascade_file)


        face_list = cascade.detectMultiScale(img, minSize=(20, 20))
	
        for (x, y, w, h) in face_list:
            border_color = (0, 0, 255)
 
            border_size = 2
            cv2.rectangle(img, (x, y), (x+w, y+h), border_color, thickness=border_size)
        

        cv2.imwrite('./output_3/img_%s.bmp'%s, img)

