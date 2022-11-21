#例1 両チームx平均値
index <- 1
plotRange <- c(-7000, 7000) #y軸の範囲　
boxplot(newdata[,index]~newdata[,86],  ylim=plotRange)

#例2 両チームx標準偏差
index <- 4
plotRange <- c(0, 4000)  #y軸の範囲　
boxplot(newdata[,index]~newdata[,86],  ylim=plotRange)

#例3 赤チームGK　x
index <- 67
plotRange <-  c(-7000, 7000)  #y軸の範囲　
boxplot(newdata[,index]~newdata[,86],  ylim=plotRange)

#例4 ボールのzの値の出力
index <- 81
plotRange <- c(-10, 2000) #y軸の範囲　
boxplot(newdata[,index]~newdata[,86],  ylim=plotRange)