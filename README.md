# MATLAB Particle Tracker

<img src="http://www.jlian.co/images/particle-tracker-in-action.png" width="400">

This is an application that can be used to track particles with a series of images. It uses algorithms adopted from the [The Matlab Particle Tracking Code Repository](http://site.physics.georgetown.edu/matlab/).

# How to use

Right now the program does not support videos yet, so you'll have to take your video and split it into individual frames. 

Convert your images to `.png` format and put them all in the same folder. 

Take a look at [`default_config.m`](https://github.com/jlian/matlab-particle-tracker/blob/master/default_config.m) which shows the values of the parameters I used in my analysis. Take a look at [this link](http://site.physics.georgetown.edu/matlab/tutorial.html) to get a better understanding of what the parameters are all about. Once you're set, put a copy of this file and name it `config.m` and put it in the same folder as your images.

Now, run `main.m` in MATLAB to get started. It will ask you where the images are placed. Navigate to it and select it. 

If everything goes well, the program will let you know and ask if you'd like to animate the results. Hopefully, your results look something like this:

<img src="http://www.jlian.co/matlab-animation/shock.gif">

If it fails then you'll have to adjust the parameters in your `config.m` through trial and error. It can be a fairly painful process. Good luck!

## More details

See [Efficient animation with MATLAB](https://johnlian.net/posts/matlab-animation/).
