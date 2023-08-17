from transformers import PegasusForConditionalGeneration, PegasusTokenizer
import sys

def summarize_text(text):
    model_name = "amazon/FalconLite"
    tokenizer = PegasusTokenizer.from_pretrained(model_name)
    model = PegasusForConditionalGeneration.from_pretrained(model_name, trust_remote_code=True)
    inputs = tokenizer([text], max_length=512, return_tensors="pt", truncation=True)
    outputs = model.generate(inputs.input_ids)
    summary = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return summary

if __name__ == '__main__':
    text = sys.stdin.read()
    print(summarize_text(text))