<?php
  $firstStage = str_replace("\n",'<br>',markitup::parseOutput ('markdown', 'REX_VALUE[id=1 output="html"]'));
  echo str_replace('<br><','<',$firstStage);
?>