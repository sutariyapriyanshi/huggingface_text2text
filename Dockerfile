# Use the official python 3.12 image
FROM python:3.12

# set the working directory to /code
WORKDIR /code

# copy the current directory contents in the container at /code
COPY ./requirements.txt /code/requirements.txt

# install requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# setup a new user named 'user'
RUN useradd user

# change the ownership of the /code directory to the user 'user'
USER user

# set home to the user's home directory
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# set the working directory to the user's home directory
WORKDIR $Home/app

# copy the current directory contents in the container at $HOME/app setting the owner to user
COPY --chown=user . $HOME/app

# start the FASTAPI app on port 7860
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]