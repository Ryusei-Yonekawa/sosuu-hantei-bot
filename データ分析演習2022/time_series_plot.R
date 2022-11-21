newdata <- read.csv("basic_data.csv", head=TRUE)

# 例1  xの平均値の出力 (長軸方向，正が右）
index <- 1
plotRange <- c(-7000, 7000) #y軸の範囲　
ylabel <- "x_ave [cm]" #y軸の名前
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+22], xlab="frame", ylab="", type="l", col="red", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+44], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# 例2  xの標準偏差の出力 (長軸方向）
index <- 4
plotRange <- c(0, 4000) #y軸の範囲　
ylabel <- "x_stdev [cm]" #y軸の名前
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+22], xlab="frame", ylab="", type="l", col="red", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+44], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# 例3  xの範囲の出力 (長軸方向）
index <- 5
plotRange <- c(0, 10000) #y軸の範囲　
ylabel <- "x_range [cm]" #y軸の名前
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+22], xlab="frame", ylab="", type="l", col="red", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+44], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# 例4　yの平均値の出力 (短軸方向，上が正）
index <- 6
plotRange <- c(-4000, 4000) #y軸の範囲　
ylabel <- "y_ave [cm]" #y軸の名前
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+22], xlab="frame", ylab="", type="l", col="red", ylim=plotRange)
par(new=TRUE)
plot(as.numeric(newdata[,index+44]), xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# 例5　キーパーのxの値の出力
index <- 67
plotRange <- c(-7000, 7000) #y軸の範囲　
ylabel <- "keeper_x [cm]" #y軸の名前
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="red",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+4], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)


# 例6　キーパーのyの値の出力
index <- 68
plotRange <- c(-4000, 4000) #y軸の範囲　
ylabel <- "keeper_y [cm]" #y軸の名前
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="red",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+4], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# 例7　ボールのzの値の出力
index <- 81
plotRange <- c(-10, 2000) #y軸の範囲　
ylabel <- "ball_z [cm]" #y軸の名前
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)