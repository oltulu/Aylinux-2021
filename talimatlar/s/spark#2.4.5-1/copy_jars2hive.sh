#!/bin/sh
# spark execution engine for hive on remote mode
cd $SPARK_HOME/jars
for _jar in `ls chill-java* chill_*  jackson-module-paranamer*  jackson-module-scala* jersey-container-servlet-core* jersey-server* json4s-ast* kryo-shaded* minlog* scala-xml* spark-launcher* spark-network-shuffle* spark-unsafe* xbean-asm6-shaded*`; do ln -s $SPARK_HOME/jars/${_jar} $HIVE_HOME/lib/;done
cd -
