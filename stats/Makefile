
graph: xen-api-lorenz linux-lorenz git-lorenz xenadmin-lorenz

xen-api-lorenz: lorenz.ml xen-api-shortlog
	cat xen-api-shortlog | ./lorenz.ml > xen-api-lorenz

linux-lorenz: lorenz.ml linux-shortlog
	cat linux-shortlog | ./lorenz.ml > linux-lorenz

git-lorenz: lorenz.ml git-shortlog
	cat git-shortlog | ./lorenz.ml > git-lorenz

xenadmin-lorenz: lorenz.ml xenadmin-shortlog
	cat xenadmin-shortlog | ./lorenz.ml > xenadmin-lorenz