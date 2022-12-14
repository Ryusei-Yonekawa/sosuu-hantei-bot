newdata <- read.csv("basic_data.csv", head=TRUE)

# ??1  x?̕??ϒl?̏o?? (?????????C?????E?j
index <- 1
plotRange <- c(-7000, 7000) #y???͈̔́@
ylabel <- "x_ave [cm]" #y???̖??O
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+22], xlab="frame", ylab="", type="l", col="red", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+44], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# ??2  x?̕W???΍??̏o?? (?????????j
index <- 4
plotRange <- c(0, 4000) #y???͈̔́@
ylabel <- "x_stdev [cm]" #y???̖??O
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+22], xlab="frame", ylab="", type="l", col="red", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+44], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# ??3  x?͈̔͂̏o?? (?????????j
index <- 5
plotRange <- c(0, 10000) #y???͈̔́@
ylabel <- "x_range [cm]" #y???̖??O
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+22], xlab="frame", ylab="", type="l", col="red", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+44], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# ??4?@y?̕??ϒl?̏o?? (?Z???????C?オ???j
index <- 6
plotRange <- c(-4000, 4000) #y???͈̔́@
ylabel <- "y_ave [cm]" #y???̖??O
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+22], xlab="frame", ylab="", type="l", col="red", ylim=plotRange)
par(new=TRUE)
plot(as.numeric(newdata[,index+44]), xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# ??5?@?L?[?p?[??x?̒l?̏o??
index <- 67
plotRange <- c(-7000, 7000) #y???͈̔́@
ylabel <- "keeper_x [cm]" #y???̖??O
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="red",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+4], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)


# ??6?@?L?[?p?[??y?̒l?̏o??
index <- 68
plotRange <- c(-4000, 4000) #y???͈̔́@
ylabel <- "keeper_y [cm]" #y???̖??O
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="red",  ylim=plotRange)
par(new=TRUE)
plot(newdata[,index+4], xlab="frame", ylab="", type="l", col="blue", ylim=plotRange)

# ??7?@?{?[????z?̒l?̏o??
index <- 81
plotRange <- c(-10, 2000) #y???͈̔́@
ylabel <- "ball_z [cm]" #y???̖??O
plot(newdata[,index], xlab="", ylab=ylabel, type="n", ylim=plotRange)
par(new=TRUE)
plot(newdata[,index], xlab="frame", ylab="", type="l", col="black",  ylim=plotRange)