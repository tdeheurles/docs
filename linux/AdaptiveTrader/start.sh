#! /bin/bash

#! /bin/bash

# update dnu
cd $ADAPTIVE_TRADER_FOLDER/src/server
cat "GetDependencies.bat" | bash

# start EventStore
sudo service eventstore start
sleep 5

# populate
if [[ ! -f .already_populated ]];then
  cat "Populate Event Store.bat" | bash
  echo "populated" > .already_populated
fi

# start crossbar.io
xterm -hold -e 'crossbar start' &
sleep 5

# start ReferenceDataRead
xterm -hold -e 'cat "ReferenceInstance.bat" | bash' &

# start Pricing
xterm -hold -e 'cat "PricingInstance.bat" | bash' &

# start WebUi
cd $ADAPTIVE_TRADER_FOLDER/src/client
xterm -hold -e 'npm install && npm run compile && npm start' &
