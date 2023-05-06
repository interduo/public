<?php
// Those functions are from stackoverflow, github and many others sources

function delete_all_between($beginning, $end, $string) {
    $beginningPos = strpos($string, $beginning);
    $endPos = strpos($string, $end);
    if ($beginningPos === false || $endPos === false) {
        return $string;
    }

    $textToDelete = substr($string, $beginningPos, ($endPos + strlen($end)) - $beginningPos);

    return delete_all_between($beginning, $end, str_replace($textToDelete, '', $string)); // recursion to ensure all occurrences are replaced
}

//alternative to:
preg_replace('/START[\s\S]+?END/', '', $string);

?>
