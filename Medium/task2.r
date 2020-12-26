# Using changepoint to compute binary segmentation models up to 5 segments
# Plot segement means on top of data

if(!require(changepoint)) {
    install.packages("changepoint")
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

# calculate changepoints
model <- changepoint::cpt.meanvar(y,penalty="Manual",pen.value='2*log(n)',method='BinSeg', Q=10)
cm = coef(model)
change.points = cpts(model)
segment.mean = cm[1]

# detected changepoints
print(change.points)

# segment means
print(segment.mean)

# plot changepoint and segment mean over data
svg('Medium/task2.svg')
plot(model, xlab="Segments", ylab="logpoint ratios of the probe", main="Neuroblastoma changepoint detection using 'changepoint'")
grid()
legend(x=5, y=-0.5,legend=c("position vs logpoint data", "segment mean", "changepoint"), col=c("black","red","blue"), lty=c(1,1,NA), pch=c(NA,NA,'X'), cex=0.8, bg='lightblue')

# add changepoints
points(change.points, as.numeric(segment.mean[[1]])[1:5], col='blue', pch='X')

dev.off()
