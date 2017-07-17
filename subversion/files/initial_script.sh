cd /tmp
echo "Downloading code from GitHub"
git clone https://github.com/dmiralles/ospos
cd /tmp/ospos
echo "Code downloaded"

#Dejando listo SVN
svn mkdir file:///opt/subversion/ospos -m "Create new folder"
svn checkout file:///opt/subversion
cd /opt/subversion/subversion/ospos
#Empaquetando OSPOS con version de PR
PR_NUMBER=1
cd /opt/subversion/subversion/ospos
echo "Compressing code"
tar -zcf opensourcepos-${PR_NUMBER}.tar.gz -C /tmp/ospos .
echo "Compressed file completed"

#Envio a SVN el paquete instalando cliente
echo "Adding package to SVN"
svn add opensourcepos-${PR_NUMBER}.tar.gz
echo "Commiting to SVN"
svn commit -m "First commit"
