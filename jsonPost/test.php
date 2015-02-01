<?php
/*
這是php server端的程式碼sample
 */
//$str="[{\"str\":\"Hello\",\"num\":1},{\"str\":\"Goodbye\",\"num\":99}]";
/*
例如取得如下的字串
"[{\"str\":\"Hello\",\"num\":1},{\"str\":\"Goodbye\",\"num\":99}]"
 */
$str=stripslashes($_POST["json"]); //要移除斜線，才能進行json_decode
$json=json_decode($str,true);
foreach($json as $v){
	//下方即可取得送來的資料，這裡把這些資料從新存成陣列，並且補了一些子資料在"test"中
$arrData[]=array(
 "num"=>$v["num"],
 "str"=>$v["str"],
 "test"=>array(
	"stat"=>"ok",
    "sub"=>"子項測試"
)
);
}
//把上面的Array再編碼成Json送回給iPhone
echo json_encode($arrData);
?>
