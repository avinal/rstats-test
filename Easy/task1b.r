# Using binsegRcpp to compute binary segmentation models up to 5 segments
# Plot segement means on top of data

if(!require(binsegRcpp)) {
    install.packages("binsegRcpp")
}

if(!require(neuroblastoma)) {
    install.packages("neuroblastoma")
}

# import and load neuroblastoma dataset
library('neuroblastoma')
data('neuroblastoma')

# using np as neuro.profiles for profile data
np = neuroblastoma$profiles
xy = np[np$profile.id == 4 & np$chromosome == 2, ]
x = xy$position
y = xy$logratio
M = matrix(c(x,y), ncol=2)
# computing binary segmentation models upto 5 segments using binsegRcpp
model <- binsegRcpp::binseg_normal(y,6)

# get changepoints and segment mean
cm = coef(model,6:6)

# create segment mean lines
change.lines = x[as.vector(matrix(c(cm$start, cm$end), ncol=length(cm$start), nrow=2, byrow=TRUE))]
segment.mean = as.vector(matrix(cm$mean, ncol=length(cm$mean), nrow=2, byrow=TRUE))

# detected changepoints
print(cm$end)

# segment means
print(cm$mean)

# plot changepoint and segment mean over data
svg('Easy/task1b.svg')
plot(x,y,type='l', xaxt='n', xlab="Segments", ylab="logpoint ratios of the probe", main="Neuroblastoma changepoint detection using 'binsegRcpp'")
axis(1, at=x[seq(1, 234, 50)], labels=seq(0, 200, 50))
grid()
legend(x=x[5], y=-0.5, legend=c("position vs logpoint data", "segment mean", "changepoint"), col=c("black","red","blue"), lty=c(1,1,NA), pch=c(NA,NA,'X'), cex=0.8, bg='lightblue')

# add segment mean
alter <- seq(1, 12, 2)
segments(x0=change.lines[alter], y0=segment.mean[alter], x1=change.lines[alter+1], y1=segment.mean[alter+1], col='red')

# add changepoints
points(as.numeric(change.lines[alter+1])[1:5], as.numeric(segment.mean[alter])[1:5], col='blue', pch='X')

dev.off()
