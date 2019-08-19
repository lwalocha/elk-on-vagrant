# elk-on-vagrant
ELK on Vagrant installation

1. Przygotowanie
- Sklonownie repozytorium z github-a 
  - git clone https://github.com/lwalocha/elk-on-vagrant.git
- Ustawienie sposobu instalacji
  - Jeżeli chcemy przyśpieszyć instalację środowiska, ściągamy lokalnie odpowiednie pliki rpm używając poniższego skryptu lub ręcznie kopiujemy je do podkalogu ./rpms 
     - ./elk_download.sh
   - Natomiast jeżeli wszystko ma się zainstalować automatycznie z repozytorium, należy ustawić wartość zmiennej globalnej es_use_repository: true (w pliku ./groups_vars/all.yml)
2. Instalacja maszyn wirtualnych
  - vagrant up
3. Instalacja i konfiguracja klastra 
  - vagrant ssh ansible-1 -c /vagrant/elk.sh
