# Adatbázis 2024-2025

Az adatbázis kezeléshez szükséges *mysql*, és egy vele együttműködő *phpmyadmin* docker compose segítségével összeállítva.

Az adatbázis adatait volume-ban tárolja!

## Indítás

A rendszer inicializálását és az első indítását a `start.sh` végzi.

```
./start.sh
```

Későbbiekben a `docker compose up` paranccsal is indítható.

```bash
docker compose up -d
```

- A `-d` hatására visszakapjuk a konzolt

## Leállítás

```bash
docker compose stop
```

## Eltávolítás

```
docker compose down -v
```

 - A `-v` hatására a köteteket is törli, így az adatbázisban tárolt adatok is megszűnnek.


## Belépés PHP MyAdminból

A reverse proxy használatához be kell állítani a `C:\Windows\System32\Drivers\etc` mappában lévő `hosts` fájlt a gépen, hogy tartalmazzon bejegyzést a `127.0.0.1`-es IP címmel a `pma.vm1.test`-re.

```
127.0.0.1 vm1.test
127.0.0.1 pma.vm1.test
...
```

Továbbá a Virtuális gépen legyen beállítva a Port forwarding a 80-as portra.

 - A phpmyadmin alapértelmezés szerint a http://pma.vm1.test címen érhető el
 - A `demo` felhasználóval be lehet lépni, akinek az alapértelmezett jelszava: `p_ssW0rd`
 - A `root` felhasználóval be lehet lépni, akinek az alapértelmezett jelszava: `root_p_ssW0rd`
 
 Mivel a phpmyadmin és az adatbázis konténerei belső hálózaton kommunikálnak egymással, így a `PMA_HOST` értéke `localhost` helyett `db` lesz.

## Csatlakozás külső programból

Külső prorgamból való csatlakozáshoz a `compose.yaml` fájlban be kell állítani, hogy a container megfelelő portja (alapértelmezetten ez a `3306`) legyen publikálva. Ezt a konfigurációt a fájl tartalmazza, csak ki van kommentelve.

```
ports:
 - 3306:3306
```

Így a virtuális gépen már elérhető, de a host gépen csak akkor lesz használható, ha a Virtuális gépen be van állítva  a Port forwarding a 3306-os portra.

Ha minden be lett állítva, az alábbi adatok egyikével lehet csatlakozni, amennyiben nem lett módosítva a `.env` fájl:


 - Host: `localhost`
 - Port: `3306`
 - Username: `demo`
 - Password: `p_ssW0rd`

vagy 

 - Host: `localhost`
 - Port: `3306`
 - Username: `root`
 - Password: `root_p_ssW0rd`


## Konzolos csatlakozás

A mappában állva az alábbi paranccsal indítható a `db` konténerben található `mysql` konzolos applikáció.

```
docker compose exec db mysql --user root --password
```

## Hibaelhárítás

A logfájlokat a `docker compose logs` jelenítni meg.

```bash
docker compose logs
```

- A PHPMyAdmin és a MySQl logjait is megjeleníti

```bash
docker compose logs db
```

- Csak a MySQl logjait jeleníti meg

```bash
docker compose logs phpmyadmin
```

- Csak a PHPMyAdmin logjait jeleníti meg

```bash
docker compose logs -f
```

- A `-f` kapcsoló azt eredményezi, hogy folyamatosan frissíti a logokat, így ellenőrizhető például a PHPMyAdmin oldal betöltése is.
- Kilépni belőle a `ctr` + `c` kombinációval lehet