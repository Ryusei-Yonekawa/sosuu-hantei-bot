################################
#基本統計量の算出関数
################################
basicInfo<-function(x){
	if(length(x[is.na(x)])==length(x)){
		list(num=NA, ave=NA, med=NA, min=NA, max=NA, q25=NA, q75=NA, 
		sd=NA, range=NA, qrange=NA)
	}else{
		list(
			num = length(x), 	#数
			#代表点に関する量
			ave = mean(x),		#平均値
			med = median(x),	#中央値
			min = min(x),		#最小値
			max = max(x),		#最大値
			q25 = quantile(x, 0.25),#第3四分位数
			q75 = quantile(x, 0.75),#第1四分位数
			#幅に関する量
			sd = sd(x),		#標準偏差
			range = max(x)-min(x),	#範囲
			qrange = IQR(x)		#四分位偏差
		)
	}
}

################################
#基本統計量の算出関数2（相関など）
################################
basicInfo2<-function(x, y){
	if(length(x[is.na(x) | is.na(y)]) >= (length(x)-2)){
		list(cor=NA, tau=NA, rho=NA)
	}else{
		list(
			cor=cor.test(x, y, method="pearson")[[4]], #ピアソンの積率相関係数
			tau=cor.test(x, y, method="kendall")[[4]], #ケンドールの順位相関係数
			rho=cor.test(x, y, method="spearman")[[4]] #スピアマンの順位相関係数
		)
	}
}

################################
#レコードの変換関数
################################
createNewRecord <- function(record){

	# 各情報の格納する変数の初期化
	playerInfoR<-NULL
	playerInfoL<-NULL
	keeperInfoR<-NULL
	keeperInfoL<-NULL
	refreeInfo<-NULL
	ballInfo<-NULL
	
	#選手情報の整理
	for(j in 0:28){
		s <- j*7 + 2
		tmp <- as.matrix(record[s:(s+6)])
		#左チーム非キーパーの場合
		if(tmp[1]=="0" && tmp[3]!="-1"){ 
			if(is.null(playerInfoL)){ 
				playerInfoL <- tmp 
			}else{
				playerInfoL<-rbind(playerInfoL, tmp)
			}
		#右チーム非キーパーの場合
		}else if(tmp[1]=="1" && tmp[3]!="-1"){ 
			if(is.null(playerInfoR)){
				playerInfoR <- tmp
			}else{
				playerInfoR<-rbind(playerInfoR, tmp)
			}
		#左チームキーパーの場合
		}else if(tmp[1]=="10"){ 
			if(is.null(keeperInfoL)){
				keeperInfoL <- tmp
			}else{
				keeperInfoL<-rbind(keeperInfoL, tmp)
			}
		#右チームキーパーの場合
		}else if(tmp[1]=="11"){
			if(is.null(keeperInfoR)){
				keeperInfoR <- tmp
			}else{
				keeperInfoR<-rbind(keeperInfoR, tmp)
			}
		#審判の場合
		}else if(tmp[1]=="3"){
			if(is.null(refreeInfo)){
				refreeInfo <- tmp
			}else{
				refreeInfo<-rbind(refreeInfo, tmp)
			}
		}
	}

	#存在しない場合の処理
	if(is.null(refreeInfo)) refreeInfo <- rep(NA, 7)
	if(is.null(keeperInfoR)) keeperInfoR <- rep(NA, 7)
	if(is.null(keeperInfoL)) keeperInfoL <- rep(NA, 7)
	

	#両チーム（非キーパー）とボール情報の作成
	playerInfoAll <- rbind(playerInfoL, playerInfoR)
	ballInfo <- record[205:210]

	#両チーム（非キーパー）基本統計量の算出	
	vec1 <- playerInfoAll[,4]
	vec2 <- playerInfoAll[,5]
	allX <- basicInfo(vec1)
	allY <- basicInfo(vec2)
	allXY<- basicInfo2(vec1, vec2)
	vec1 <- playerInfoAll[,6]
	vec2 <- playerInfoAll[,7]
	allVX <- basicInfo(vec1)
	allVY <- basicInfo(vec2)
	allVXY<- basicInfo2(vec1, vec2)

	#左チーム（非キーパー）基本統計量の算出
	vec1 <- playerInfoL[,4]
	vec2 <- playerInfoL[,5]
	teamLX <- basicInfo(vec1)
	teamLY <- basicInfo(vec2)
	teamLXY<- basicInfo2(vec1, vec2)
	vec1 <- playerInfoL[,6]
	vec2 <- playerInfoL[,7]
	teamLVX <- basicInfo(vec1)
	teamLVY <- basicInfo(vec2)
	teamLVXY<- basicInfo2(vec1, vec2)

	#右チーム（非キーパー）基本統計量の算出
	vec1 <- playerInfoR[,4]
	vec2 <- playerInfoR[,5]
	teamRX <- basicInfo(vec1)
	teamRY <- basicInfo(vec2)
	teamRXY<- basicInfo2(vec1, vec2)
	vec1 <- playerInfoR[,6]
	vec2 <- playerInfoR[,7]
	teamRVX <- basicInfo(vec1)
	teamRVY <- basicInfo(vec2)
	teamRVXY<- basicInfo2(vec1, vec2)

	#両チーム（非キーパー）集計結果を新レコードに追加
	newrecord <- c(allX$ave, allX$min, allX$max, allX$sd, allX$range)
	newrecord <- c(newrecord, allY$ave, allY$min, allY$max, allY$sd, allY$range)
	newrecord <- c(newrecord, allXY$cor)
	newrecord <- c(newrecord, allVX$ave, allVX$min, allVX$max, allVX$sd, allVX$range)
	newrecord <- c(newrecord, allVY$ave, allVY$min, allVY$max, allVY$sd, allVY$range)
	newrecord <- c(newrecord, allVXY$cor)

	#左チーム選手（非キーパー）集計結果を新レコードに追加
	newrecord <- c(newrecord, teamLX$ave, teamLX$min, teamLX$max, teamLX$sd, teamLX$range)
	newrecord <- c(newrecord, teamLY$ave, teamLY$min, teamLY$max, teamLY$sd, teamLY$range)
	newrecord <- c(newrecord, teamLXY$cor)
	newrecord <- c(newrecord, teamLVX$ave, teamLVX$min, teamLVX$max, teamLVX$sd, teamLVX$range)
	newrecord <- c(newrecord, teamLVY$ave, teamLVY$min, teamLVY$max, teamLVY$sd, teamLVY$range)
	newrecord <- c(newrecord, teamLVXY$cor)


	#右チーム選手（非キーパー）集計結果を新レコードに追加
	newrecord <- c(newrecord, teamRX$ave, teamRX$min, teamRX$max, teamRX$sd, teamRX$range)
	newrecord <- c(newrecord, teamRY$ave, teamRY$min, teamRY$max, teamRY$sd, teamRY$range)
	newrecord <- c(newrecord, teamRXY$cor)
	newrecord <- c(newrecord, teamRVX$ave, teamRVX$min, teamRVX$max, teamRVX$sd, teamRVX$range)
	newrecord <- c(newrecord, teamRVY$ave, teamRVY$min, teamRVY$max, teamRVY$sd, teamRVY$range)
	newrecord <- c(newrecord, teamRVXY$cor)
	
	#その他情報を新レコードに追加
	newrecord <- c(newrecord, keeperInfoL[4:7])
	newrecord <- c(newrecord, keeperInfoR[4:7])
	newrecord <- c(newrecord, refreeInfo[4:7])
	newrecord <- c(newrecord, matrix(ballInfo, 1))

	return(newrecord)
}