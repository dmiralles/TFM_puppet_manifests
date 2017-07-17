cd /tmp
git clone https://github.com/dmiralles/ospos
cd /tmp/ospos

#Empaquetando OSPOS con version de PR
PR_NUMBER=1
cd /opt/subversion
tar -zcvf opensourcepos-${PR_NUMBER}.tar.gz -C /opt/subversion .

#Dejando listo SVN
svn mkdir file:///opt/subversion/ospos -m "Create new folder"
svn checkout /opt/subversion
cd /opt/subversion/subversion/ospos

#Envio a SVN el paquete instalando cliente
echo "Adding package to SVN"
svn add opensourcepos-${PR_NUMBER}.tar.gz
echo "Commiting to SVN"
svn commit -m "First commit
