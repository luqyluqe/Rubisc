Gem::Specification.new do |s|
	s.name='rubisc'
	s.version='0.3.1'
	s.date='2017-07-31'
	s.licenses=['MIT']
	s.summary='Wicked cool ruby scripts'
	s.description='Wicked cool ruby scripts'
	s.authors=['luqyluqe']
	s.email='luqy.luqe@gmail.com'
	s.files=['rubisc.rb','bin/assert-contains','bin/substitute','bin/xcodeproj-scan','bin/pod-publish','bin/pod-publish.sh','lib/fileutil.rb']
	s.executables<<'assert-contains'
	s.executables<<'substitute'
	s.executables<<'xcodeproj-scan'
	s.executables<<'pod-publish'
	s.executables<<'pod-publish.sh'
	s.homepage='https://github.com/luqyluqe/Rubisc'
end
