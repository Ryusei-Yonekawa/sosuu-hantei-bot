#関数群の読み込み
source("functions.R")

#dataの読み込み
data <- read.csv("data_sample_clean3.csv", head=TRUE)  #データの読み込み

ndata<-length(data[,1])

#加工後データの作成
newdata <- NULL
for(i in 1:ndata){
	record <- data[i,]
	nvalue <- length(record)
	tmp <- NULL	
	newrecord<-createNewRecord(record)
	if(is.null(newdata)){
		newdata <- matrix(newrecord, 1)
	}else{
		newdata <- rbind(newdata, matrix(newrecord, 1))
	}
}
newdata <- cbind(newdata, data[,(ncol(data)-1):ncol(data)])


for(i in 1:ncol(newdata)){
	newdata[,i] <- as.numeric(newdata[,i])
}

#加工後データの変数名付与
colnames(newdata) <- 
c(
	"all_x_ave", "all_x_min", "all_x_max", "all_x_sd", "all_x_range",
	"all_y_ave", "all_y_min", "all_y_max", "all_y_sd", "all_y_range",
	"all_xy_cor",
	"all_vx_ave", "all_vx_min", "all_vx_max", "all_vx_sd", "all_vx_range",
	"all_vy_ave", "all_vy_min", "all_vy_max", "all_vy_sd", "all_vy_range",
	"all_vxy_cor",
	"teamL_x_ave", "teamL_x_min", "teamL_x_max", "teamL_x_sd", "teamL_x_range",
	"teamL_y_ave", "teamL_y_min", "teamL_y_max", "teamL_y_sd", "teamL_y_range",
	"teamL_xy_cor",
	"teamL_vx_ave", "teamL_vx_min", "teamL_vx_max", "teamL_vx_sd", "teamL_vx_range",
	"teamL_vy_ave", "teamL_vy_min", "teamL_vy_max", "teamL_vy_sd", "teamL_vy_range",
	"teamL_vxy_cor",
	"teamR_x_ave", "teamR_x_min", "teamR_x_max", "teamR_x_sd", "teamR_x_range",
	"teamR_y_ave", "teamR_y_min", "teamR_y_max", "teamR_y_sd", "teamR_y_range",
	"teamR_xy_cor",
	"teamR_vx_ave", "teamR_vx_min", "teamR_vx_max", "teamR_vx_sd", "teamR_vx_range",
	"teamR_vy_ave", "teamR_vy_min", "teamR_vy_max", "teamR_vy_sd", "teamR_vy_range",
	"teamR_vxy_cor",
	"teamLKeeper_x", "teamLKeeper_y", "teamLKeeper_vx", "teamLKeeper_vy",
	"teamRKeeper_x", "teamRKeeper_y", "teamRKeeper_vx", "teamRKeeper_vy",
	"refree_x", "refree_y", "refree_vx", "refree_vy",
	"ball_x", "ball_y", "ball_z", "ball_vx", "ball_vy", "ball_vz", 
	"event_team", "event_code")


#加工後データの保存
write.csv(newdata, "basic_data.csv", row.names=FALSE) 
