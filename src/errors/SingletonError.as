package errors {
	public class SingletonError extends Error{
		public function SingletonError() {
			super("Can not create instance of Singleton class. Use getInstance() instead.");
		}
	}
}
