from dockerspawner import DockerSpawner
from jupyterhub.auth import DummyAuthenticator
import os

c = get_config()

# konfiguracja adresów i portów
c.JupyterHub.bind_url = 'http://0.0.0.0:8000'
c.JupyterHub.hub_ip = 'jupyterhub'
c.JupyterHub.hub_port = 8081
c.JupyterHub.cookie_secret_file = '/data/jupyterhub_cookie_secret'
c.JupyterHub.db_url = 'sqlite:////data/jupyterhub.sqlite'

# --------- publiczny adres z ngroka------------
c.JupyterHub.external_url = 'https://22f0-185-13-184-55.ngrok-free.app/hub/'  # <- ZMIEŃ TO!
# --------- publiczny adres z ngroka------------


# Zaufanie do nagłówków reverse proxy (ngrok)
c.JupyterHub.trust_xheaders = True

# Konfiguracja Dockera
c.JupyterHub.spawner_class = DockerSpawner
c.DockerSpawner.image = 'notebook_img'
c.DockerSpawner.remove = True
c.DockerSpawner.debug = True
c.DockerSpawner.network_name = os.environ.get("DOCKER_NETWORK_NAME", "jupyterhub_default")

# DummyAuthenticator
c.JupyterHub.authenticator_class = DummyAuthenticator
c.Authenticator.admin_users = {'admin'}
c.Authenticator.allowed_users = {'admin', '173137'}
c.DummyAuthenticator.password = 'test'

# Hooki i katalogi
notebook_dir = '/home/jovyan/work'
shared_dir = '/home/jovyan/shared'
teacher_users = {'admin'}

def pre_spawn_hook(spawner):
    username = spawner.user.name
    role = 'teacher' if username in teacher_users else 'student'

    user_volume = f'jupyterhub-user-{username}'

    spawner.volumes = {
        user_volume: notebook_dir,
        "jupyterhub-shared": {
            "bind": shared_dir,
            "mode": "ro" if role == "student" else "rw"
        }
    }

    def create_symlink_hook(spawner):
        link_path = os.path.join(notebook_dir, "shared")
        if not os.path.exists(link_path):
            os.symlink(shared_dir, link_path)

    spawner.post_spawn_hook = create_symlink_hook

c.Spawner.pre_spawn_hook = pre_spawn_hook
c.Spawner.default_url = '/lab'
