GithHub-Homework dokumentáció

Először is létre lett hozva egy .yml file, ami Homework néven fut, és akkor futtatja le a workflowt ha a push történik a main branchen

"""
name: Homework

on:
  push:
    branches:
      - main
"""

Ezután definiálva lettek a beépített jobok, amik először is egy ubuntu alapot vesz alapul, majd végrehajt egy checkout művletet a repositoryból
'''
jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
    - name: Check out the repo
      uses: actions/checkout@v2

'''

Ezt követően bejelentkezik a docker hub profilba, amihez a belépők github secretként rögzítve lettek a repoban.
'''
    - name: Log in to Docker Hub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}
'''

A workflow létrehoz egy docker filet és pusholja a docker hubra a korábban megadótt belépőinfók alapján:
'''
    - name: Build and push Docker image
      uses: docker/build-push-action@v2
      with:
        context: .
        file: ./Dockerfile
        push: true
        tags: ${{ secrets.DOCKER_USERNAME }}/homework:latest
'''

A lenti dockerfile tartalmazza a szükséges nginx dockert, aminél megadtam azt is, hogy induláskor automatikusan fusson le, majd tegye elérhetővé a html file a 80-as porton.

'''
FROM nginx:latest
COPY index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "daemon off;"]
'''

Az utolsó file pedig az expose-olt html fájl, ami az én nevemet fogja megjeleníteni.
'''
DevOps homework by: < Csábi Gergő >
'''
       
