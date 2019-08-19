1. Przygotowanie
  1.1. Sklonownie repozytorium z github-a
    git clone https://github.com/lwalocha/elk-on-vagrant.git
  1.2. Ustawienie sposobu instalacji
    1.2.1. Jeżeli chcemy przyśpieszyć instalację środowiska, ściągamy lokalnie odpowiednie pliki rpm używając poniższego skryptu lub ręcznie kopiujemy je do podkalogu ./rpms
      ./elk_download.sh 
    1.2.2 Natomiast jeżeli wszystko ma się zainstalować automatycznie z repozytorium, należy ustawić wartość zmiennej globalnej es_use_repository: true (w pliku ./groups_vars/all.yml) 
2. Instalacja maszyn wirtualnych
  vagrant up
3. Instalacja i konfiguracja klastra
  vagrant ssh ansible-1 -c /vagrant/elk.sh

