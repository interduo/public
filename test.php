<?php

$var[1] = "";
$var[2] = null;
$var[3] = 0;
$var[4] = 1;
unset($var[5]);

function testit($v) {
    $v = ($v =='' || !isset($v)) ? true : false;
    return $v;
}

foreach ($var as $key=>$v) {
	print 'wyniktestu dla zmiennej-' . $key . ' ' . testit($v) . ' ' . PHP_EOL;
}
	print 'wyniktestu dla zmiennej-5' . testit($var[5]);
?>
