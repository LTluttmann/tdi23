import logging
from git import Repo
import os
import shutil
from pwd import getpwnam


logger = logging.getLogger(__name__)
flog = logging.FileHandler("/home/tdi2023/usrhooks.log")
flog.setFormatter(logging.Formatter("%(asctime)s %(message)s"))
logger.addHandler(flog)
logger.setLevel(logging.INFO)


ERASE_DIR = False

def clone_repo(user, git_url, repo_dir):
    """
    A function to clone a github repo into a specific directory of a user.
    """
    Repo.clone_from(git_url, repo_dir)
    uid = getpwnam(user).pw_uid
    gid = getpwnam(user).pw_gid
    for root, dirs, files in os.walk(repo_dir):
        for d in dirs:
            shutil.chown(os.path.join(root, d), user=uid, group=gid)
        for f in files:
            shutil.chown(os.path.join(root, f), user=uid, group=gid)


def create_dir_hook(spawner):
    """
    A function to clone a github repo into a specific directory of a
    JupyterHub user when the server spawns a new notebook instance.
    """
    username = spawner.user.name
    logger.info("User %s just logged in..." % username)
    DIR_NAME = os.path.join("/home", "jupyter-%s" % username)
    
    git_url = "https://github.com/ProfessorKazarinoff/ENGR101.git"
    repo_dir = os.path.join(DIR_NAME, 'notebooks')

    if ERASE_DIR == True:
        logger.info("Fetching repo %s ..." % git_url)
        if os.path.isdir(repo_dir):
            shutil.rmtree(repo_dir)
        os.mkdir(repo_dir)
        clone_repo(username, git_url, repo_dir)

    if ERASE_DIR == False and not (os.path.isdir(repo_dir)):
        logger.info("Fetching repo %s ..." % git_url)
        os.mkdir(repo_dir)
        clone_repo(username, git_url, repo_dir)

    if ERASE_DIR == False and os.path.isdir(repo_dir):
        logger.info("User is already setup")
        pass

    logger.info("Done.")

c.Spawner.pre_spawn_hook = create_dir_hook