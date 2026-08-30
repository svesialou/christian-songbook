type ScrollReturnButtonProps = {
  isReturning: boolean;
  onClick: () => void;
};

const ScrollReturnButton = ({ isReturning, onClick }: ScrollReturnButtonProps) => (
  <button
    type="button"
    className={`scroll-return-button ${isReturning ? 'is-returning' : ''}`}
    onClick={onClick}
    aria-label={isReturning ? 'Вернуться обратно к месту в списке' : 'Перейти наверх списка'}
  >
    <span aria-hidden="true">{isReturning ? '↓' : '↑'}</span>
    {isReturning ? 'Вернуться обратно' : 'Наверх'}
  </button>
);

export default ScrollReturnButton;
