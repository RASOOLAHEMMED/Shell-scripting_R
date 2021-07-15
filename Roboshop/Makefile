help:  		##print this message
	@fgrep -h '##' $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/://' -e 's/##//'
frontend:	##install frontend component
	@bash frontend.sh
cart:		##install cart component
	@bash cart.sh
catalogue:	##install cart component
	@bash catalogue.sh
payment:	##install payment component
	@bash payment.sh
shipping:	##install shipping component
	@bash shipping.sh
user:		##install user component
	@bash user.sh
mongodb:	##install mongodb component
	@bash mongodb.sh
mysql:		##install mysql component
	@bash mysql.sh
rabbitmq:	##install rabbitmq component
	@bash rabbitmq.sh
redis:		##install redis component
	@bash redis.sh
databases:	##install all Databases
databases: mongodb redis mysql rabbitmq
