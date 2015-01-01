docker-gotour
=============

How do I use docker-gotour?
===========================

You can either run

 docker pull shymega/docker-gotour 

to download the image from the Docker registry, or build the image yourself by running;

docker build -t gotour .

To run docker-gotour, just execute:
docker run -it gotour (You don't have to use -it to run the image, it's just useful for debugging and finding the container IP address - however you can do just the same with docker attach {CONTAINER-ID} )

License
=======

docker-gotour is licensed under the MIT License [LICENSE.md](LICENSE.md)

Contributing
============

Want to contribute? Fork this repo and submit a pull request. I'm always happy to read through any ideas and improvements you have to make for my projects. 

Bear in mind though, I am quite busy with education, so I'll try and sort out your issues quickly, but it could be a while!


Happy coding,
shymega


