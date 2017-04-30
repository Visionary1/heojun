Class _Private
{
	__Call(method, args*)
	{
		If IsObject(method) || (method == "")
			Return method ? this.Call(method, args*) : this.Call(args*)
	}
}