FROM sysdig/kube-psp-advisor:latest


MAINTAINER John Menerick projectnexus@pm.me


ADD 
	./init.sh /init.sh


RUN 
	chmod u+x /init.sh


ENTRYPOINT ["/init.sh"]
