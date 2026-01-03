build:
	@echo "Building Golang with Windows XP support docker image"
	@docker build -t goxp:1.24.4 .

build-test-app:
	@echo "Building a simple hello world compatible with Windows XP"
	@docker run --rm -v "$(shell pwd)/test_app":/work -e GOOS=windows -e GOARCH=386 -e GO386=softfloat goxp:1.24.4 go build -trimpath -o app.exe .
	@mv test_app/app.exe hellowxp.exe
