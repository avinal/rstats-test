# download data 'neuroblastoma' and plot profile.id = 4, chromosome = 4, x=position, y=logratio
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

svg('Easy/task1a.svg')
plot(x, y, type='l', main="Neuroblastoma Data", xlab='position in base pair', ylab='normalized logratio of the probe')
grid()
legend(x=x[5], y=-0.5,legend="position vs logpoint data", col="black", lty=1, cex=0.8, bg='lightblue')
dev.off()
