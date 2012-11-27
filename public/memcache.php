<?php

$mc = new Memcache; 
$mc->connect("33.33.33.11", 11211); 

$mc->set("foo", "Hello!"); 

echo $mc->get('foo');