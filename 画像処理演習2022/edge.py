# coding: utf-8 

import cv2

for num in range(2001):
	s = str(num).zfill(6)
	img = cv2.imread('./images/img_%s.bmp'%s)

	dst = cv2.Canny(img,100,200) # ‰Û‘è4.1‚Å‚Í‚±‚Ì•Ó‚ð‚¢‚¶‚é

	cv2.imwrite('./output/dst_%s.bmp'%s, dst)

